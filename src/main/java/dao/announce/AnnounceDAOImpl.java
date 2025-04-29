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

	@Override
	public int insert(Announce announce)throws Exception {
        try {
            int result = session.insert("mapper.announce.insert", announce);
            session.commit(); 
            return result;
        } catch (Exception e) {
            session.rollback();  
            throw e;  
        } finally {
            session.close();  
        }
    }

	@Override
	public int update(Announce announce)throws Exception {
        try {
            int result = session.update("mapper.announce.update", announce);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

	@Override
	public int delete(List<Integer> noList)throws Exception {
        try {
            int result = session.delete("mapper.announce.delete", noList);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

	@Override
	public Announce selectOne(int no)throws Exception {
        try {
            return session.selectOne("mapper.announce.selectOne", no);
        } catch (Exception e) {
            throw e;  
        } finally {
            session.close();
        }
    }


	
}
