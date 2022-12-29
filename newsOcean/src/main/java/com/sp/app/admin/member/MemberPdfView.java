package com.sp.app.admin.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class MemberPdfView extends AbstractPdfView {
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String filename = (String)model.get("filename");
		
		List<String> columnLabels = (List<String>)model.get("columnLabels");
		List<Object[]> columnValues = (List<Object[]>)model.get("columnValues");
		
		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "attachment; filename="+filename);
		
		//글꼴!
		BaseFont baseFont = BaseFont.createFont("c:\\windows\\fonts\\malgun.ttf",
				BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		
		Font font = new Font(baseFont);
		
		font.setSize(20);
		font.setStyle(Font.BOLD);
		
		//문장 표현
		Paragraph p = new Paragraph("뉴스오션 회원리스트", font);
		p.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p);
		
		
		
		
		
	}
	
}
