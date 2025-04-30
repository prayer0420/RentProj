package dao.mypage;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import dto.Order;
import utils.MybatisSqlSessionFactory;

public class MypageDAOImpl implements MypageDAO {

    @Override
    public Integer selectProductCountById(String id) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectOne("mapper.mypage.selectProductCnt", id);
        }
    }

    @Override
    public List<Map<String, Object>> selectProductListByPage(Map<String, Object> paramMap) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.mypage.selectProductListByPage", paramMap);
        }
    }

    @Override
    public void updateLocation(String memberId, double latitude, double longitude) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> params = new HashMap<>();
            params.put("memberId", memberId);
            params.put("latitude", latitude);
            params.put("longitude", longitude);
            session.update("mapper.member.updateLocation", params);
            session.commit();
        }
    }

    @Override
    public Map<String, Object> selectMySellDetail(Integer orderNo, String id) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("orderNo", orderNo);
            param.put("id", id);
            return session.selectOne("mapper.mypage.selectMySellDetail", param);
        }
    }

    @Override
    public boolean updateInvoiceInfo(Integer orderNo, String deliveryComp, String invoiceNo) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("orderNo", orderNo);
            param.put("deliveryComp", deliveryComp);
            param.put("invoiceNo", invoiceNo);
            Integer result = session.update("mapper.mypage.updateInvoiceNo", param);
            session.commit();
            return result == 1;
        }
    }

    @Override
    public Integer selectOrderCountById(String id) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectOne("mapper.mypage.selectOrderCnt", id);
        }
    }

    @Override
    public List<Map<String, Object>> selectOrderListByPage(Map<String, Object> paramMap) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.mypage.selectOrderListByPage", paramMap);
        }
    }

    @Override
    public Map<String, Object> selectMyOrderDetail(Integer orderNo, String id) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("orderNo", orderNo);
            param.put("id", id);
            return session.selectOne("mapper.mypage.selectMyOrderDetail", param);
        }
    }

    @Override
    public Integer selectRentCountById(String id) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectOne("mapper.mypage.selectRentCnt", id);
        }
    }

    @Override
    public List<Map<String, Object>> selectRentListByPage(Map<String, Object> paramMap) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.mypage.selectRentListByPage", paramMap);
        }
    }

    @Override
    public Map<String, Object> selectMyRentDetail(Integer orderNo, String id) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("orderNo", orderNo);
            param.put("id", id);
            return session.selectOne("mapper.mypage.selectMyRentDetail", param);
        }
    }

    @Override
    public Integer selectLendCountById(String id) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectOne("mapper.mypage.selectLendCnt", id);
        }
    }

    @Override
    public List<Map<String, Object>> selectLendListByPage(Map<String, Object> paramMap) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.mypage.selectLendListByPage", paramMap);
        }
    }

    @Override
    public Map<String, Object> selectMyLendDetail(Integer orderNo, String id) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("orderNo", orderNo);
            param.put("id", id);
            return session.selectOne("mapper.mypage.selectMyLendDetail", param);
        }
    }

    @Override
    public Map<String, Object> selectLendDetailByOrderNo(String id, Integer orderNo) throws Exception {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Map<String, Object> param = new HashMap<>();
            param.put("orderNo", orderNo);
            param.put("id", id);
            return session.selectOne("mapper.mypage.selectLendHistoryDetail", param);
        }
    }

    @Override
    public List<Order> selectLendHistoryByProductNo(Integer productNo) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return session.selectList("mapper.mypage.selectLendHistoryByProductNo", productNo);
        }
    }

    @Override
    public Integer deleteProduct(Integer productNo) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Integer result = session.delete("mapper.mypage.deleteMyProduct", productNo);
            session.commit();
            return result;
        }
    }

    @Override
    public boolean updateOrderStatusToCompleted(Integer orderNo) {
        try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            Integer result = session.update("mapper.mypage.updateOrderStatusToCompleted", orderNo);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
} 
