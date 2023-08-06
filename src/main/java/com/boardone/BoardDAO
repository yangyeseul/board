package com.boardone;

import java.util.*;
import java.sql.*;

public class BoardDAO {

	private static BoardDAO instance = null;
	
	private BoardDAO() {
		
	}

	public static BoardDAO getInstance() {
		
		if(instance == null) {
			synchronized (BoardDAO.class) {
				instance = new BoardDAO();
			}
		}
		
		return instance;
	}
	
	
	// 글쓰기 폼에서 넘어온 데이터를 실제 데이터베이스에 넣어줄 메소드
	public void insertArticle(BoardVO article) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = article.getNum();
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();
		
		int number = 0;
		String sql = "";
		
		try {
			conn = ConnUtil.getConnection();
			sql = "select max(num) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}
			
			if(num != 0) { // 답변글인 경우
				sql = "update board set step = step + 1 where ref=? and step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, step);
				pstmt.executeUpdate();
				
				step = step + 1;
				depth = depth + 1;
			} else { // 새글
				ref = number;
				step = 0;
				depth = 0;
			}
			
			sql = "insert into board(num, writer, email, subject, pass, regdate, ref, step, depth, content, ip) values(board_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPass());
			pstmt.setTimestamp(5, article.getRegdate());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, step);
			pstmt.setInt(8, depth);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
	} // end insertArticle


	// 전체 글 갯수를 가져오는 메소드
	public int getArticleCount() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int x = 0;
		
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("select count(*) from board");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return x;
	
	} // end getArticleCount
	
	
	/*
	public List<BoardVO> getArticles() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<BoardVO> articleList = null;
		
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("select * from board order by num desc");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList<BoardVO>();
				
				do {
					BoardVO article = new BoardVO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPass(rs.getString("pass"));
					article.setRegdate(rs.getTimestamp("regdate"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setStep(rs.getInt("step"));
					article.setDepth(rs.getInt("depth"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				} while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return articleList;
	} // end getArticles
	*/
	
	// 전체 글 갯수를 가져오는 메소드
	// 한페이지에 몇개만 리스트로 잡을지 정하기
	public List<BoardVO> getArticles(int start, int end) { // 여기 수정해야됨 1 : 파라미터 start, end 삽입
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List<BoardVO> articleList = null;
		
		try {
			conn = ConnUtil.getConnection();
			// 여기 수정해야됨 2
			String sql = "select * from (select rownum rnum, num, writer,email, subject, pass, regdate, readcount, ref, step, depth, content, ip from (select * from board order by ref desc, step asc)) where rnum >=? and rnum <=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 여기 수정해야됨 3
				articleList = new ArrayList<BoardVO>(end - start+1);
				
				do {
					BoardVO article = new BoardVO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPass(rs.getString("pass"));
					article.setRegdate(rs.getTimestamp("regdate"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setStep(rs.getInt("step"));
					article.setDepth(rs.getInt("depth"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				} while(rs.next());
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return articleList;
	} // end getArticles
	
	
	// list.jsp 페이지에서 제목을 클릭했을 경우 글 내용을 볼 수 있게 구현
	// num을 파라미터로 하나의 글에 대한 상세 정보를 데이터베이스에서 가져오기
	public BoardVO getArticle(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		BoardVO article = null;
		
		try {
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("update board set readcount=readcount+1 where num=?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("select * from board where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return article;
	} // end getArticle
	
	
	// 글 수정버튼 클릭시 updateForm.jsp 페이지로 이동
	// 글 수정시 글 목록 보기에서 조회수를 증가시킬 필요x, 조회수 증가는 제외하고 수정처리
	public BoardVO updateGetArticle(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardVO article = null;
		
		try {
			
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("select * from board where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardVO();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPass(rs.getString("pass"));
				article.setRegdate(rs.getTimestamp("regdate"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setStep(rs.getInt("step"));
				article.setDepth(rs.getInt("depth"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
			}
			
			
		}  catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return article;
	} // end updateGetArticle
	
	
	// 수정 버튼을 클릭했을 경우 데이터베이스에 저장되어 있던 글도 수정처리가 되어야 함
	public int updateArticle(BoardVO article) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String dbPasswd= "";
		String sql = "";
		int result = -1;
		
		try {
			
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("select pass from board where num=?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 입력 번호와 데이터베이스 비밀번호 비교
				dbPasswd = rs.getString("pass");
				
				if(dbPasswd.equals(article.getPass())) { // 비밀번호가 일치하면
					sql = "update board set writer=?, email=?, subject=?, content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getContent());
					pstmt.setInt(5, article.getNum());
					pstmt.executeUpdate();
					
					result = 1;
				} else {
					result = 0;
				}
			}
			
			
		}  catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return result;
	} // end updateArticle
	
	
	// 비밀번호 입력하고 삭제 버튼을 클릭하면 데이터베이스에 저장된 비밀번호와 비교하여 일치하면 삭제 처리
	public int deleteArticle(int num, String pass) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String dbPasswd= "";
		int result = -1;
		
		try {
			
			conn = ConnUtil.getConnection();
			pstmt = conn.prepareStatement("select pass from board where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 입력 번호와 데이터베이스 비밀번호 비교
				dbPasswd = rs.getString("pass"); // 데이터베이스의 비밀번호 dbPasswd에 저장
				
				if(dbPasswd.equals(pass)) { // 비밀번호가 일치하면
					pstmt = conn.prepareStatement("delete from board where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
					result = 1; // 삭제 성공
 				} else {
					result = 0; // 삭제 실패
				}
			}
			
			
		}  catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {rs.close();} catch(SQLException s) {}
			} 
			
			if(pstmt != null) {
				try {pstmt.close();} catch(SQLException s) {}
			} 
			
			if(conn != null) {
				try {conn.close();} catch(SQLException s) {}
			} 
		}
		
		return result;
	} // end deleteArticle
}
