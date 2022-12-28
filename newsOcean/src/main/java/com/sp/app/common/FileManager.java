package com.sp.app.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("fileManager")
public class FileManager {
	/**
	 * 파일을 업로드 하기 위한 메소드
	 * 
	 * @param partFile 업로드할 파일정보를 가지고 있는 MultipartFile 객체
	 * @param pathname 파일을 저장할 경로
	 * @return 서버에 저장된 새로운 파일의 이름
	 */
	public String doFileUpload(MultipartFile partFile, String pathname) throws Exception {
		String saveFilename = null;

		if (partFile == null || partFile.isEmpty()) {
			return null;
		}

		// 클라이언트가 업로드한 파일의 이름
		String originalFilename = partFile.getOriginalFilename();
		if (originalFilename == null || originalFilename.length() == 0) {
			return null;
		}

		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if (fileExt == null || fileExt.length() == 0) {
			return null;
		}

		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance())
					+ System.nanoTime() + fileExt;

		String fullpathname = pathname + File.separator + saveFilename;
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File f = new File(fullpathname);
		if (! f.getParentFile().exists()) {
			f.getParentFile().mkdirs();
		}

		partFile.transferTo(f);

		return saveFilename;
	}

	/**
	 * 파일을 업로드 하기 위한 메소드
	 * 
	 * @param bytes            업로드할 파일정보를 가지고 있는byte 배열
	 * @param originalFilename 클라이언트가 업로드한 파일명
	 * @param pathname         파일을 저장할 경로
	 * @return 서버에 저장된 새로운 파일의 이름
	 */
	public String doFileUpload(byte[] bytes, String originalFilename, String pathname) throws Exception {
		String saveFilename = null;

		if (bytes == null) {
			return null;
		}

		// 클라이언트가 업로드한 파일의 이름
		if (originalFilename == null || originalFilename.length() == 0) {
			return null;
		}

		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if (fileExt == null || fileExt.length() == 0) {
			return null;
		}

		// 서버에 저장할 새로운 파일명을 만든다.
		saveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance())
					+ System.nanoTime() + fileExt;

		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(pathname);
		if (! dir.exists()) {
			dir.mkdirs();
		}

		String fullpathname = pathname + File.separator + saveFilename;

		FileOutputStream fos = new FileOutputStream(fullpathname);
		fos.write(bytes);
		fos.close();

		return saveFilename;
	}

	/**
	 * 파일을 다운로드하는 메소드
	 * 
	 * @param saveFilename     서버에 저장된 파일이름
	 * @param originalFilename 클라이언트가 업로드한 파일이름
	 * @param pathname         파일이 저장된 경로
	 * @param response         응답할 HttpServletResponse 객체
	 * @return 파일 다운로드 성공 여부
	 */
	public boolean doFileDownload(String saveFilename, String originalFilename, String pathname, HttpServletResponse resp) {
		String fullpathname = pathname + File.separator + saveFilename;

		try {
			if (originalFilename == null || originalFilename.length() == 0) {
				originalFilename = saveFilename;
			}
			originalFilename = new String(originalFilename.getBytes("euc-kr"), "8859_1");
			
			File file = new File(fullpathname);

			if (file.exists()) {
				byte readByte[] = new byte[4096];

				resp.setContentType("application/octet-stream");
				resp.setHeader("Content-disposition", "attachment;filename=" + originalFilename);

				BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
				// javax.servlet.ServletOutputStream os = resp.getOutputStream();
				OutputStream os = resp.getOutputStream();

				int read;
				while ((read = bis.read(readByte, 0, 4096)) != -1) {
					os.write(readByte, 0, read);
				}
				os.flush();
				os.close();
				bis.close();

				return true;
			}
		} catch (Exception e) {
		}

		return false;
	}

	/**
	 * 파일들을 zip 파일로 압축하여 다운로드하는 메소드
	 * 
	 * @param sources     폴더명을 포함한 서버에 저장된 압축할 파일들(경로 포함)
	 * @param originals   압축할 파일들이 압축될 때의 파일명
	 * @param zipFilename 다운로드할 때 클라이언트에 표시할 zip 파일명
	 * @param response    응답할 HttpServletResponse 객체
	 * @return 파일 다운로드 성공 여부
	 */
	public boolean doZipFileDownload(String[] sources, String[] originals, String zipFilename, HttpServletResponse resp) {
		String pathname = System.getProperty("user.dir") + File.separator + "temp";
		String archiveFilename;

		// 파일들을 압축
		archiveFilename = fileCompression(sources, originals, pathname);
		if (archiveFilename == null) {
			return false;
		}

		// 파일 다운로드
		boolean b = doFileDownload(archiveFilename, zipFilename, pathname, resp);

		// 압축한 zip 파일 삭제
		String fullpathname = pathname + File.separator + archiveFilename;
		doFileDelete(fullpathname);

		return b;
	}

	/**
	 * 파일들을 압축하는 메소드
	 * 
	 * @param sources   폴더명을 포함한 압축할 파일들
	 * @param originals 압축할 파일들이 압축될 때의 파일명
	 * @param pathname  압축 파일을 저장할 경로
	 * @return 압축된 파일명
	 */
	public String fileCompression(String[] sources, String[] originals, String pathname) {
		String archiveFilename = null;
		String fullpathname = null;

		final int MAX_SIZE = 2048;
		byte[] buf = new byte[MAX_SIZE];
		String s;
		File f;

		ZipOutputStream zos = null;
		FileInputStream fis = null;
		try {
			f = new File(pathname);
			if (!f.exists()) {
				f.mkdirs();
			}

			archiveFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance())
							+ System.nanoTime() + ".zip";
			fullpathname = pathname + File.separator + archiveFilename;

			zos = new ZipOutputStream(new FileOutputStream(fullpathname));

			int length;
			for (int idx = 0; idx < sources.length; idx++) {
				fis = new FileInputStream(sources[idx]);

				// 압축파일에 압축되는 파일명
				// zos.putNextEntry(new ZipEntry(sources[idx]));
				if (originals != null && originals.length >= idx) {
					if (originals[idx].indexOf(File.separator) == -1) {
						s = originals[idx];
					} else {
						s = originals[idx].substring(originals[idx].lastIndexOf(File.separator));
					}
				} else {
					s = sources[idx].substring(sources[idx].lastIndexOf(File.separator));
				}
				
				if (s.indexOf(File.separator) == -1) {
					s = File.separator + s;
				}
				zos.putNextEntry(new ZipEntry(s)); // 압축 파일명은 "\파일명.확장자" 형식으로 설정해야 압축된다.

				length = 0;
				while ((length = fis.read(buf)) > 0) {
					zos.write(buf, 0, length);
				}
				zos.closeEntry();
				fis.close();
			}
			fis.close();
		} catch (IOException e) {
		} finally {
			try {
				zos.closeEntry();
				zos.close();
			} catch (IOException e) {
			}
		}

		f = new File(fullpathname);
		if (!f.exists()) {
			return null;
		}

		return archiveFilename;
	}

	/**
	 * 파일을 삭제하는 메소드
	 * 
	 * @param pathname 경로를 포함한 삭제할 파일이름
	 */
	public void doFileDelete(String pathname) {
		File file = new File(pathname);
		if (file.exists()) {
			file.delete();
		}
	}

	/**
	 * 파일을 삭제하는 메소드
	 * 
	 * @param filename 삭제할 파일 이름
	 * @param pathname 삭제할 파일이 존재하는 경로
	 */
	public void doFileDelete(String filename, String pathname) {
		String fullpathname = pathname + File.separator + filename;
		File file = new File(fullpathname);
		if (file.exists()) {
			file.delete();
		}
	}

	/**
	 * 파일 또는 폴더 및 하위 폴더를 삭제하는 메소드
	 * 
	 * @param pathname 삭제할 파일명(경로포함) 또는 삭제할 폴더
	 */
	public void removePathname(String pathname) {
		try {
			File f = new File(pathname);
			if (! f.exists()) {
				return;
			}

			if (f.isDirectory()) {
				removeSubDirectory(pathname);
			}

			f.delete();
		} catch (Exception e) {
		}
	}

	private void removeSubDirectory(String pathname) {
		File[] listFile = new File(pathname).listFiles();
		try {
			if (listFile.length > 0) {
				for (int i = 0; i < listFile.length; i++) {
					if (listFile[i].isDirectory()) {
						removeSubDirectory(listFile[i].getPath());
					}
					listFile[i].delete();
				}
			}
		} catch (Exception e) {
		}
	}

	/**
	 * 파일의 길이를 구하는 메소드
	 * 
	 * @param pathname 길이를 구할 경로를 포함한 파일이름
	 * @return 파일의 길이
	 */
	public long getFilesize(String pathname) {
		long size = -1;

		File file = new File(pathname);
		if (! file.exists()) {
			return size;
		}

		size = file.length();

		return size;
	}

	/**
	 * 파일의 타입을 구하는 메소드
	 * 
	 * @param pathname 파일 타입을 구할 파일이름
	 * @return 파일 타입
	 */
	public String getFiletype(String pathname) {
		String type = "";
		try {
			URL u = new URL("file:" + pathname);
			URLConnection uc = u.openConnection();
			type = uc.getContentType();
		} catch (Exception e) {
		}

		return type;
	}
	
	/**
	 * 동일한 파일이름이 있는 경우 파일명 뒤에(숫자)를 붙이고 "파일명(숫자)" 파일명이 존재하면 "파일명(숫자+1)" 로 재귀적으로 작성 
	 * @param filename		파일이름
	 * @param pathname		파일경로
	 * @param seq			파일명 뒤에 붙일 숫자(처음 호출할 때는 1로 전달) 
	 * @return				새로운 파일명
	 */
	public String appendSuffixFilename(String filename, String pathname, long seq) {
		String result = filename;
		
		String fullpathname = pathname + File.separator + filename;
		
		if(! new File(fullpathname).exists()) {
			return result;
		}
		
		try {
			String firstFilename = filename.substring(0, filename.lastIndexOf("."));
			String extName = filename.substring(filename.lastIndexOf("."));
			
			long num = seq;
			if(firstFilename.matches(".*\\(\\d{1,}\\)$")) {
				String snum = firstFilename.substring(firstFilename.lastIndexOf("(") + 1, firstFilename.length() - 1);
				num = Long.parseLong(snum) + 1;
				firstFilename = firstFilename.substring(0, firstFilename.lastIndexOf("(") + 1) + num + ")";
			} else {
				firstFilename = firstFilename + "(" + num + ")";
			}
			
			filename = firstFilename + extName;
			
			return appendSuffixFilename(filename, pathname, num);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
