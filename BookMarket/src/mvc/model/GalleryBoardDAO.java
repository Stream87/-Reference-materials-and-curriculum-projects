package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import mvc.database.DBConnection;

public class GalleryBoardDAO {

	private static GalleryBoardDAO instance;
	
	private GalleryBoardDAO() {
	}

	public static GalleryBoardDAO getInstance() {
		if (instance == null)
			instance = new GalleryBoardDAO();
		return instance;
	}
	
	public int getListCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement("select count(*) from galleryboard");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return x;
	}

	
	public List<GalleryBoardDTO> getGalleryBoardList(int page, int limit, String items, String text) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int total_record = getListCount();
		int start = (page - 1) * limit;
		int index = start + 1;

		String sql;

		if (items == null && text == null)
			sql = "select * from galleryboard ORDER BY num DESC";
		else
			sql = "SELECT  * FROM galleryboard where " + items + " like '%" + text + "%' ORDER BY num DESC ";

		List<GalleryBoardDTO> list = new ArrayList<GalleryBoardDTO>();

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.absolute(index)) {

				GalleryBoardDTO galleryboard = new GalleryBoardDTO();
				galleryboard.setNum(rs.getInt("num"));
				galleryboard.setId(rs.getString("id"));
				galleryboard.setName(rs.getString("name"));
				galleryboard.setSubject(rs.getString("subject"));
				galleryboard.setContent(rs.getString("content"));
				galleryboard.setRegist_day(rs.getString("regist_day"));
				galleryboard.setHit(rs.getInt("hit"));
				galleryboard.setIp(rs.getString("ip"));		
				galleryboard.setFilename(rs.getString("filename"));
				int ripple_total_record = getListRippleCount(rs.getInt("num"));
				galleryboard.setRipple_count(ripple_total_record);
				list.add(galleryboard);

				if (index < (start + limit) && index <= total_record)
					index++;
				else
					break;
			}

			return list;
		} catch (Exception ex) {
			System.out.println("getGalleryBoardList() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
			
			
		}
		return null;
	}
	public void insertGalleryBoard(GalleryBoardDTO galleryboard)  {

		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			conn = DBConnection.getConnection();

			//conn.setAutoCommit(false);

					     
			String sql = "insert into galleryboard values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, galleryboard.getNum());			
			pstmt.setString(2, galleryboard.getId());
			pstmt.setString(3, galleryboard.getName());
			pstmt.setString(4, galleryboard.getSubject());
			pstmt.setString(5, galleryboard.getContent());
			pstmt.setString(6, galleryboard.getRegist_day());
			pstmt.setInt(7, galleryboard.getHit());
			pstmt.setString(8, galleryboard.getIp());
			pstmt.setString(9, galleryboard.getFilename());
			pstmt.setLong(10, galleryboard.getFilesize());
			pstmt.executeUpdate();
			pstmt.close();
			//conn.commit();
			sql = "SELECT num FROM galleryboard WHERE regist_day =?" ;	
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, galleryboard.getRegist_day());
			rs = pstmt.executeQuery();		
			
			
			if (rs.next()) {			
				sql = "UPDATE galleryboard SET group_num = ? where num = ?"; 	
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("num"));
				pstmt.setInt(2, rs.getInt("num"));
				pstmt.executeUpdate();	
				
			}
			

		} catch (Exception ex) {
			System.out.println("insertGalleryBoard() 에러 : " + ex);
		} finally {
			try {				
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		
	} 

	public void updateHit(int num) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DBConnection.getConnection();

			String sql = "select hit from galleryboard where num = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next()) {
				hit = rs.getInt("hit") + 1;
			}

			sql = "update galleryboard set hit=? where num=?";
			pstmt = conn.prepareStatement(sql);

			// 자동 커밋을 false로 한다.
			//conn.setAutoCommit(false);

			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);

			pstmt.executeUpdate();
			// 완료시 커밋
			//conn.commit();

		} catch (Exception ex) {
			System.out.println("updateHit() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
			
		}

	}

	public GalleryBoardDTO getGalleryBoardByNum(int num, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GalleryBoardDTO galleryboard = null;

		updateHit(num);
		String sql = "select * from galleryboard where num = ? ";

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {

				galleryboard = new GalleryBoardDTO();
				galleryboard.setNum(rs.getInt("num"));			
				galleryboard.setId(rs.getString("id"));
				galleryboard.setName(rs.getString("name"));
				galleryboard.setSubject(rs.getString("subject"));
				galleryboard.setContent(rs.getString("content"));
				galleryboard.setRegist_day(rs.getString("regist_day"));
				galleryboard.setHit(rs.getInt("hit"));
				galleryboard.setIp(rs.getString("ip"));
				galleryboard.setFilename(rs.getString("filename"));
				galleryboard.setFilesize(rs.getLong("filesize"));
			}

			return galleryboard;
		} catch (Exception ex) {
			System.out.println("getGalleryBoardByNum() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}

	

	public void updateGalleryBoard(GalleryBoardDTO galleryboard) {

		Connection conn = null;
		PreparedStatement pstmt = null;
	
		String sql;
		try {

			conn = DBConnection.getConnection();
			System.out.print("1111111111111111"+galleryboard.getFilename());
			
			// 자동 커밋을 false로 한다.
			conn.setAutoCommit(false);
			if (galleryboard.getFilename()==null) {
				sql = "update galleryboard set name=?, subject=?, content=? where num=?";
				pstmt = conn.prepareStatement(sql);

				
				pstmt.setString(1, galleryboard.getName());
				pstmt.setString(2, galleryboard.getSubject());
				pstmt.setString(3, galleryboard.getContent());			
				pstmt.setInt(4, galleryboard.getNum());
				pstmt.executeUpdate();
			}
			else
			{
				sql = sql = "update galleryboard set name=?, subject=?, content=?, filename=?, filesize=? where num=?";
				pstmt = conn.prepareStatement(sql);

				
				pstmt.setString(1, galleryboard.getName());
				pstmt.setString(2, galleryboard.getSubject());
				pstmt.setString(3, galleryboard.getContent());
				pstmt.setString(4, galleryboard.getFilename());
				pstmt.setLong(5, galleryboard.getFilesize());
				pstmt.setInt(6, galleryboard.getNum());
				pstmt.executeUpdate();
			}

		
			// 완료시 커밋
			conn.commit();

		} catch (Exception ex) {
			System.out.println("updateGalleryBoard() 에러 : " + ex);
		} finally {
			try {				
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		
	} 
	public void deleteGalleryBoard(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		

		String sql = "delete from galleryboard where num=?";
	

		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteGalleryBoard() 에러 : " + ex);
		} finally {
			try {
				
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}

	}
	
	//ripple
	public int getListRippleCount(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		int x = 0;
			
		try {
			conn = DBConnection.getConnection();
			sql = "SELECT count(*)  FROM galleryripple where parent= ?  ORDER BY num DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return x;
	}
	
	
	public List<GalleryRippleDTO>  getGalleryBoardRippleByNum(int num, int page) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		
		List<GalleryRippleDTO> list = new ArrayList<GalleryRippleDTO>();
		int i= 0;	
		try {
			conn = DBConnection.getConnection();
			String sql = "select * from galleryripple where parent= ?  ORDER BY num DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				GalleryRippleDTO galleryboard = new GalleryRippleDTO();
				galleryboard.setNum(rs.getInt("num"));
				galleryboard.setParent(rs.getInt("parent"));
				galleryboard.setId(rs.getString("id"));
				galleryboard.setName(rs.getString("name"));
				galleryboard.setContent(rs.getString("content"));				
				galleryboard.setRegist_day(rs.getString("regist_day"));
				galleryboard.setIp(rs.getString("ip"));	
				
				list.add(galleryboard);
			}
			
			return list;
		} catch (Exception ex) {
			System.out.println("getGalleryBoardRippleByNum() 에러 : " + ex);
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		return null;
	}

	
	public void insertGalleryRipple(GalleryRippleDTO galleryboard)  {

		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			conn = DBConnection.getConnection();

			//conn.setAutoCommit(false);

					     
			String sql = "insert into galleryripple values(?, ?, ?, ?, ?, ?, ?)";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, galleryboard.getNum());
			pstmt.setInt(2, galleryboard.getParent());
			pstmt.setString(3, galleryboard.getId());
			pstmt.setString(4, galleryboard.getName());
			pstmt.setString(5, galleryboard.getContent());
			pstmt.setString(6, galleryboard.getRegist_day());
			pstmt.setString(7, galleryboard.getIp());
			pstmt.executeUpdate();		
			

		} catch (Exception ex) {
			System.out.println("insertGalleryRipple() 에러 : " + ex);
		} finally {
			try {				
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}
		
	} 

	public void deleteGalleryRipple(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = DBConnection.getConnection();
			String sql = "delete from galleryripple where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			

		} catch (Exception ex) {
			System.out.println("deleteGalleryRipple() 에러 : " + ex);
		} finally {
			try {
				
				if (pstmt != null) {
					pstmt.close();
					pstmt = null;
				}
				if (conn != null) {
					conn.close();
					conn = null;
				}
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}		
		}

	}	
	
	
}
