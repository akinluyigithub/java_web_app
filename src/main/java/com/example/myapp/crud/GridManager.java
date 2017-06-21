package com.example.myapp.crud;

import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.example.myapp.crud.entity.Grid;
import com.example.myapp.crud.entity.GridColumn;
import org.apache.poi.ss.usermodel.Cell;

@Stateless
public class GridManager {

	@PersistenceContext(unitName = "MyPersistenceUnit")
	private EntityManager em;

	@Inject
	GenericManager genericManager;

	/**
	 * For a given grid (and entity), extract only the columns specified in the
	 * Grid.
	 * 
	 * @param grid
	 * @return
	 */
	public List<?> find(Grid grid) {

		String query = "SELECT ";
		String comma = "";
		for (GridColumn c : grid.getColumns()) {
			if (c.getOrder() == null)
				continue; // not needed
			query += comma;
			query += c.getAttributeName();
			comma = ",";
		}
		query += " FROM " + grid.getEntity();

		// TODO order by? filters?

		List<?> items = em.createQuery(query).getResultList();
		if (!items.isEmpty()) {
			System.out.println("CLASS= " + items.get(0).getClass());
		}
		return items;
	}

	/**
	 * Export grid in XLSX format.
	 * 
	 * Similar routines could be implemented for XLS and CSV.
	 * 
	 * @param grid
	 * @return
	 */
	public XSSFWorkbook excel(Grid grid) {
		List<?> items = find(grid);

		XSSFWorkbook wb = new XSSFWorkbook();
		XSSFSheet sheet = wb.createSheet();
		Row row = sheet.createRow(0);

		int colnum = 0;
		for (GridColumn gc : grid.getColumns()) {
			if (gc.getOrder() == null)
				continue; // this means not needed in view
			Cell c = row.createCell(colnum++);
			// c.setCellStyle(arg0); //TODO
			c.setCellValue(gc.getDescription()); // TODO i18n
		}

		for (Object item : items) {
			colnum = 0;
			for (GridColumn gc : grid.getColumns()) {
				Cell c = row.createCell(colnum++);
				// c.setCellValue(item.method());
			}
		}

		return wb;
	}

}