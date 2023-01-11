package com.sp.app.admin.member;

import java.awt.Color;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
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
		
		font.setSize(16);
		font.setStyle(Font.BOLD);

		//문장 표현
		Paragraph p = new Paragraph("뉴스오션 회원 리스트", font);
		p.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p);
		
		
		Font font_date = new Font(baseFont);
		
		font_date.setSize(9);
		font_date.setStyle(Font.BOLD);
		
		
		//오늘날짜 - 다운 일자 
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		String sysdate = sdf.format(date);
		
		Paragraph p_date = new Paragraph(sysdate, font_date);
		p_date.setAlignment(Paragraph.ALIGN_RIGHT);
		document.add(p_date);
		
		
		Font font_title = new Font(baseFont);
		
		font_title.setSize(8);
		font_title.setStyle(Font.BOLD);
		font_title.setColor(Color.WHITE);
		PdfPTable table = new PdfPTable(columnLabels.size()); // 한행의 컬럼수
		table.setWidthPercentage(100);
		//table.setWidths(new int[] {110,80,300,130,100,50,130,130,130,100,100});
		table.setSpacingBefore(40);
		
		PdfPCell cell;
		for(int i=0; i<columnLabels.size(); i++) {
			cell = new PdfPCell(new Paragraph(columnLabels.get(i), font_title));
			cell.setBackgroundColor(new Color(0, 75, 129));
			cell.setHorizontalAlignment(Cell.ALIGN_CENTER);
			cell.setFixedHeight(25);
			cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
			
			table.addCell(cell);
		}
		
		font.setSize(7);
		font.setStyle(Font.NORMAL);
		font.setColor(new Color(0, 0, 0));
		
		for(int i=0; i<columnValues.size(); i++) {
			Object[] values = columnValues.get(i);
			
			for(int col=0; col < values.length; col++) {
				cell = new PdfPCell(new Paragraph(values[col].toString(), font));
				cell.setHorizontalAlignment(Cell.ALIGN_CENTER);
				cell.setFixedHeight(25);
				cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
				
				table.addCell(cell);
			}
			
		}
		
		table.setSpacingAfter(60);
		
		document.add(table);
		
		
	}
	
}
