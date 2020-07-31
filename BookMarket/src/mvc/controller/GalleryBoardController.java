package mvc.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mvc.model.GalleryBoardDAO;
import mvc.model.GalleryBoardDTO;
import mvc.model.GalleryRippleDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class GalleryBoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());

		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");

		if (command.equals("/GalleryBoardListAction.do")) {
			requestGalleryBoardList(request);
			RequestDispatcher rd = request.getRequestDispatcher("./galleryboard/list.jsp");
			rd.forward(request, response);
		} else if (command.equals("/GalleryBoardWriteForm.do")) {
			RequestDispatcher rd = request.getRequestDispatcher("./galleryboard/writeForm.jsp");
			rd.forward(request, response);
		} else if (command.equals("/GalleryBoardWriteAction.do")) {
			requestGalleryBoardWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/GalleryBoardListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/GalleryBoardViewAction.do")) {
			requestGalleryBoardView(request);
			RequestDispatcher rd = request.getRequestDispatcher("./galleryboard/view.jsp");
			rd.forward(request, response);
		} else if (command.equals("/GalleryBoardUpdateForm.do")) {
			requestGalleryBoardView(request);
			RequestDispatcher rd = request.getRequestDispatcher("./galleryboard/updateForm.jsp");
			rd.forward(request, response);
		} else if (command.equals("/GalleryBoardUpdateAction.do")) {
			requestGalleryBoardUpdate(request);
			RequestDispatcher rd = request.getRequestDispatcher("/GalleryBoardListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/GalleryBoardDeleteAction.do")) {
			requestGalleryBoardDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/GalleryBoardListAction.do");
			rd.forward(request, response);
		} else if (command.equals("/GalleryRippleWriteAction.do")) {
			requestGalleryRippleWrite(request);
			RequestDispatcher rd = request.getRequestDispatcher("/GalleryBoardViewAction.do");
			rd.forward(request, response);
		} else if (command.equals("/GalleryRippleDeleteAction.do")) {
			requestGalleryRippleDelete(request);
			RequestDispatcher rd = request.getRequestDispatcher("/GalleryBoardViewAction.do");
			rd.forward(request, response);
		}

	}

	public void requestGalleryBoardList(HttpServletRequest request) {

		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();
		List<GalleryBoardDTO> galleryboardlist = new ArrayList<GalleryBoardDTO>();

		int pageNum = 1;
		int limit = 12;

		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		String items = request.getParameter("items");
		String text = request.getParameter("text");

		int total_record = dao.getListCount();
		galleryboardlist = dao.getGalleryBoardList(pageNum, limit, items, text);

		int total_page;

		if (total_record % limit == 0) {
			total_page = total_record / limit;
			Math.floor(total_page);
		} else {
			total_page = total_record / limit;
			Math.floor(total_page);
			total_page = total_page + 1;
		}

		request.setAttribute("pageNum", pageNum);
		request.setAttribute("total_page", total_page);
		request.setAttribute("total_record", total_record);
		request.setAttribute("boardlist", galleryboardlist);

	}

	public void requestGalleryBoardWrite(HttpServletRequest request) {

		MultipartRequest multi = null;
		int sizeLimit = 5 * 1024 * 1024;
		String savePath = "c:\\upload";

		try {
			multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

		} catch (Exception e) {
			e.printStackTrace();
		}

		Enumeration files = multi.getFileNames();
		String fname = (String) files.nextElement();
		String filename = multi.getFilesystemName(fname);

		// String filename = multi.getFilesystemName("fileImage");
		long filesize = 0;

		File file1 = multi.getFile(fname);
		if (file1 != null) {
			filesize = file1.length();
			System.out.print("颇老农扁111 " + filesize);
		}
		System.out.print("颇老农扁 " + filesize);
		System.out.print("颇老农扁 " + filename);
		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();

		GalleryBoardDTO galleryboard = new GalleryBoardDTO();
		galleryboard.setId(multi.getParameter("id"));
		galleryboard.setName(multi.getParameter("name"));
		galleryboard.setSubject(multi.getParameter("subject"));
		galleryboard.setContent(multi.getParameter("content"));
		galleryboard.setFilename(filename);
		galleryboard.setFilesize(filesize);

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());

		galleryboard.setHit(0);
		galleryboard.setRegist_day(regist_day);
		galleryboard.setIp(request.getRemoteAddr());

		dao.insertGalleryBoard(galleryboard);

	}

	public void requestGalleryBoardView(HttpServletRequest request) {

		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		GalleryBoardDTO galleryboard = new GalleryBoardDTO();
		galleryboard = dao.getGalleryBoardByNum(num, pageNum);

		List<GalleryRippleDTO> galleryripplelist = new ArrayList<GalleryRippleDTO>();
		galleryripplelist = dao.getGalleryBoardRippleByNum(num, pageNum);

		request.setAttribute("num", num);
		request.setAttribute("page", pageNum);
		request.setAttribute("galleryboard", galleryboard);
		request.setAttribute("ripplelist", galleryripplelist);

	}

	public void requestGalleryBoardUpdate(HttpServletRequest request) {

		// int num = Integer.parseInt(request.getParameter("num"));
		// int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();
		GalleryBoardDTO galleryboard = new GalleryBoardDTO();

		MultipartRequest multi = null;
		int sizeLimit = 5 * 1024 * 1024;
		String savePath = "c:\\upload";

		try {
			multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

		} catch (Exception e) {
			e.printStackTrace();
		}

		Enumeration files = multi.getFileNames();
		String fname = (String) files.nextElement();
		String filename = multi.getFilesystemName(fname);

		// String filename = multi.getFilesystemName("fileImage");
		long filesize = 0;

		File file1 = multi.getFile(fname);
		if (file1 != null) {
			filesize = file1.length();
		}

		int pageNum = Integer.parseInt(multi.getParameter("pageNum"));
		galleryboard.setNum(Integer.parseInt(multi.getParameter("num")));
		galleryboard.setId(multi.getParameter("id"));
		galleryboard.setName(multi.getParameter("name"));
		galleryboard.setSubject(multi.getParameter("subject"));
		galleryboard.setContent(multi.getParameter("content"));
		galleryboard.setFilename(filename);
		galleryboard.setFilesize(filesize);

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());

		galleryboard.setHit(0);
		galleryboard.setRegist_day(regist_day);
		galleryboard.setIp(request.getRemoteAddr());

		dao.updateGalleryBoard(galleryboard);

	}

	public void requestGalleryBoardDelete(HttpServletRequest request) {

		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();
		dao.deleteGalleryBoard(num);

	}
	// ripple

	public void requestGalleryRippleWrite(HttpServletRequest request) {

		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));

		GalleryRippleDTO galleryripple = new GalleryRippleDTO();

		galleryripple.setParent(num);
		galleryripple.setId(request.getParameter("id"));
		galleryripple.setName(request.getParameter("name"));
		galleryripple.setContent(request.getParameter("content"));

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");
		String regist_day = formatter.format(new java.util.Date());

		galleryripple.setRegist_day(regist_day);

		String ip = request.getRemoteAddr();
		galleryripple.setIp(request.getRemoteAddr());

		dao.insertGalleryRipple(galleryripple);

	}

	public void requestGalleryRippleDelete(HttpServletRequest request) {

		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int rippleNum = Integer.parseInt(request.getParameter("rippleNum"));

		GalleryBoardDAO dao = GalleryBoardDAO.getInstance();
		dao.deleteGalleryRipple(rippleNum);
	}

}
