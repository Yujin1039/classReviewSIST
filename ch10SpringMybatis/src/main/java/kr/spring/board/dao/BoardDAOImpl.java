package kr.spring.board.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.spring.board.vo.BoardVO;

//@Repository: bean 자동 스캔을 위해 dao에 꼭 있어야함
@Repository
public class BoardDAOImpl implements BoardDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void insertBoard(BoardVO board) {
		sqlSession.insert("insertBoard",board);
	}

	@Override
	public int selectBoardCount() {
		//                          sql문 작성시 참조하는 id명
		return sqlSession.selectOne("selectBoardCount");
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Integer> map) {
		//                                 id명        데이터
		return sqlSession.selectList("selectBoardList",map);
	}

	@Override
	public BoardVO selectBoard(int num) {
		return sqlSession.selectOne("selectBoard",num);
	}

	@Override
	public void updateBoard(BoardVO board) {
		sqlSession.update("updateBoard", board);
	}

	@Override
	public void deleteBoard(int num) {
		sqlSession.delete("deleteBoard",num);
	}

}
