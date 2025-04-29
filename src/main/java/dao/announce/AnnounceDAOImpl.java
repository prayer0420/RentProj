package dao.announce;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Announce;
import utils.MybatisSqlSessionFactory;

public class AnnounceDAOImpl implements AnnounceDAO {
	SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	@Override
	public List<Announce> selectAll() throws Exception {
		return session.selectList("mapper.announce.announceSelectAll");
	}
	@Override
	public Announce selectOne(Integer no) throws Exception {
		return session.selectOne("mapper.announce.announceSelectOne");
	}

}
