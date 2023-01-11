package com.sp.app.admin.perform;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.document.AbstractXlsxView;

@SuppressWarnings("unchecked")
@Service("excel_sales")
public class MyExcelView extends AbstractXlsxView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, Workbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		//중복 있음 안된다.
		String filename = (String)model.get("filename");
		String sheetName = (String)model.get("sheetName");
		
		//타이틀
		List<String> columnLabels = (List<String>)model.get("columnLabels");
		//값
		List<Object[]> columnValues = (List<Object[]>)model.get("columnValues");
		
		response.setContentType("application/ms-excel");
		response.setHeader("Content-disposition", "attachment; filename="+filename);
		
		Sheet sheet = createSheet(workbook, 0, sheetName);
		

		//폰트 제목
		Font font_t = workbook.createFont();
		font_t.setFontHeight((short)(18*18));
		font_t.setBold(true);
		font_t.setFontName("LINE Seed Sans KR Bold");
		
		//폰트 테이블 제목
		Font fontTitle = workbook.createFont();
		fontTitle.setFontHeight((short)(14*14));
		fontTitle.setBold(true);
		fontTitle.setFontName("LINE Seed Sans KR Bold");
		fontTitle.setColor(IndexedColors.WHITE.getIndex());
		
		//폰트 테이블 
		Font fontTable = workbook.createFont();
		fontTable.setFontHeight((short)(13*13));
		fontTable.setBold(true);
		fontTable.setFontName("LINE Seed Sans KR Regular");
		
		//스타일 - 큰 제목
		CellStyle stTitle__t = workbook.createCellStyle();
		stTitle__t.setAlignment(HorizontalAlignment.CENTER);
		stTitle__t.setVerticalAlignment(VerticalAlignment.CENTER);
		stTitle__t.setFont(font_t);
		
		//스타일 - 테이블 제목
		CellStyle stTitle = workbook.createCellStyle();
		stTitle.setAlignment(HorizontalAlignment.CENTER);
		stTitle.setVerticalAlignment(VerticalAlignment.CENTER);
		stTitle.setBorderBottom(BorderStyle.DASHED);
		stTitle.setFillForegroundColor(IndexedColors.DARK_TEAL.getIndex());
		stTitle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		stTitle.setFont(fontTitle);
		
		
		//스타일 - 테이블 
		CellStyle stTable = workbook.createCellStyle();
		stTable.setAlignment(HorizontalAlignment.RIGHT);
		stTable.setVerticalAlignment(VerticalAlignment.CENTER);
		stTable.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
		stTable.setFont(fontTable);
		
		
		//오늘날짜 
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String sysdate = sdf.format(date);

		
		if(columnLabels != null) {
			//시트에다 컬럼들 이름 넣어줌
			//시트 안에 큰 제목
			Row row_t = sheet.createRow(0);
			Cell cell_t;
			
			cell_t = row_t.createCell(0);
			
			if((String)model.get("member") != null) { //가입자 
				cell_t.setCellValue("뉴스오션 가입자 통계" + " (" + sysdate +"기준)");
			} else {
				cell_t.setCellValue("뉴스오션 매출 통계" + " (" + sysdate +"기준)");
			}
			
			cell_t.setCellStyle(stTitle__t);
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));
			
			
			Row labelRow = sheet.createRow(2);
			//테이블 제목
			Cell cell;
			for(int idx = 0; idx < columnLabels.size(); idx++) {
				sheet.setColumnWidth(idx, 260 * 20); //컬럼폭
				
				cell = labelRow.createCell(idx);
				cell.setCellStyle(stTitle);
				cell.setCellValue(columnLabels.get(idx));
			}
			
		}
		
		if(columnLabels != null) {
			//데이터 넣어줌
			Row row;
			Cell cell;
			
			for(int idx=0; idx < columnValues.size(); idx++) {
				row = sheet.createRow(idx+3);
				
				Object[] values = columnValues.get(idx);
				for(int col=0; col < values.length; col ++) {
					try {
						cell = row.createCell(col);
						cell.setCellStyle(stTable);
						
						if(values[col] instanceof Byte) {
							cell.setCellValue((Byte) values[col]);
						} else if (values[col] instanceof Short) {
							cell.setCellValue((Short) values[col]);
						} else if (values[col] instanceof Integer) {
							cell.setCellValue((Integer) values[col]);
						} else if (values[col] instanceof Long) {
							cell.setCellValue((Long) values[col]);
						} else if (values[col] instanceof Float) {
							cell.setCellValue((Float) values[col]);
						} else if (values[col] instanceof Double) {
							cell.setCellValue((Double) values[col]);
						} else if (values[col] instanceof Character) {
							cell.setCellValue((Character) values[col]);
						} else if (values[col] instanceof Boolean) {
							cell.setCellValue((Boolean) values[col]);
						} else if (values[col] instanceof String) {
							cell.setCellValue((String) values[col]);
						} else {
							cell.setCellValue(values[col].toString());
						}
						
					} catch (Exception e) {
					}
				}
				
			}
			
			
		}
		
		
	}

	//시트 만들기
	private Sheet createSheet(Workbook workbook, int sheetIdx, String sheetName) {
		Sheet sheet=workbook.createSheet();
		workbook.setSheetName(sheetIdx, sheetName);
		//빈 시트 만들어짐 
		return sheet;
	}
	
	
	
	
}
