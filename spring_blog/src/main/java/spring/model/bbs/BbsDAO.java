package spring.model.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import spring.utility.blog.DBClose;
import spring.utility.blog.DBOpen;

@Repository
public class BbsDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public boolean checkRefno(int bbsno) {

		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		ResultSet rs = null;

		sql.append(" select count(refno) from bbs  ");
		sql.append(" where refno = ?  ");

		try {
			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				int cnt = rs.getInt(1);
				if (cnt > 0)
					flag = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return flag;
	}

	public boolean create(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno, filename, filesize) ");
		sql.append(" values(  (SELECT NVL(MAX(bbsno), 0) + 1 FROM bbs), ");
		sql.append(" ?, ?, ?, ?, sysdate,  ");
		sql.append(" (SELECT NVL(MAX(grpno), 0) + 1 FROM bbs), ? , ?) ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getFilename());
			pstmt.setInt(6, dto.getFilesize());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0) {
				flag = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}

	public List<BbsDTO> list(Map map) {
		
		return sqlSession.selectList("bbs.list", map);
		
	}

	public void upViewcnt(int bbsno) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" update bbs set ");
		sql.append(" viewcnt = viewcnt + 1");
		sql.append(" where bbsno = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
	}

	public BbsDTO read(int bbsno) {

		return sqlSession.selectOne("bbs.read", bbsno);
	}

	public BbsDTO readReply(int bbsno) {

		BbsDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" select bbsno,title, grpno, indent, ansnum  from bbs ");
		sql.append(" where bbsno = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		return dto;

	}

	public void upAnsnum(Map map) {
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		int grpno = (Integer) map.get("grpno");
		int ansnum = (Integer) map.get("ansnum");

		sql.append(" update bbs set  ");
		sql.append(" ansnum = ansnum + 1  ");
		sql.append(" where grpno = ?   ");
		sql.append(" and ansnum > ?  ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

	}

	public boolean createReply(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(
				" insert into bbs(bbsno, wname, title, content, passwd, wdate, grpno, indent, ansnum, refno, filename, filesize) ");
		sql.append(" values((SELECT NVL(MAX(bbsno), 0) + 1 FROM bbs), ");
		sql.append(" ?, ?, ?, ?, sysdate,  ");
		sql.append(" ?, ");
		sql.append(" ?, ");
		sql.append(" ?, ");
		sql.append(" ?, ");
		sql.append(" ?, ");
		sql.append(" ?) ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getGrpno()); // 遺�紐⑥쓽 grpno
			pstmt.setInt(6, dto.getIndent() + 1);// 遺�紐⑥쓽 indent +1
			pstmt.setInt(7, dto.getAnsnum() + 1);// 遺�紐⑥쓽 ansnum +1
			pstmt.setInt(8, dto.getBbsno());
			pstmt.setString(9, dto.getFilename());
			pstmt.setInt(10, dto.getFilesize());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0) {
				flag = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}

	public boolean update(BbsDTO dto) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" update bbs set ");
		sql.append(" wname = ?, ");
		sql.append(" title = ?, ");
		sql.append(" content = ?, ");
		sql.append(" passwd = ? ");
		if (dto.getFilesize() > 0) {
			sql.append(" , filename = ?, ");
			sql.append(" filesize = ? ");
		}
		sql.append(" where bbsno = ? ");

		try {

			int i = 0;

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(++i, dto.getWname());
			pstmt.setString(++i, dto.getTitle());
			pstmt.setString(++i, dto.getContent());
			pstmt.setString(++i, dto.getPasswd());
			if (dto.getFilesize() > 0) {
				pstmt.setString(++i, dto.getFilename());
				pstmt.setInt(++i, dto.getFilesize());
			}

			pstmt.setInt(++i, dto.getBbsno());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0) {
				flag = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}

	public boolean passCheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int bbsno = (Integer) map.get("bbsno");
		String passwd = (String) map.get("passwd");

		StringBuffer sql = new StringBuffer();
		sql.append(" select count(bbsno) as cnt ");
		sql.append(" from bbs ");
		sql.append(" where bbsno = ? and passwd= ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);

			rs = pstmt.executeQuery();
			rs.next();
			int cnt = rs.getInt("cnt");

			if (cnt > 0) {
				flag = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return flag;
	}

	public boolean delete(int bbsno) {

		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();

		sql.append(" delete from bbs  ");
		sql.append(" where bbsno = ?  ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);

			int cnt = pstmt.executeUpdate();

			if (cnt > 0) {
				flag = true;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}

	public int total(String col, String word) {
		int total = 0;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*)   ");
		sql.append(" from bbs ");
		if (word.trim().length() > 0) {
			sql.append(" where " + col + " like '%'||?||'%' ");
		}

		try {
			pstmt = con.prepareStatement(sql.toString());
			if (word.trim().length() > 0) {
				pstmt.setString(1, word);
			}

			rs = pstmt.executeQuery();
			if (rs.next()) {

				total = rs.getInt(1);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return total;

	}

}