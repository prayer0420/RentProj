package service.review;

import java.util.List;
import dao.review.ReviewDAO;
import dao.review.ReviewDAOImpl;
import dto.Review;
import dto.ReviewQueryParams;
import utils.PageInfo;

public class ReviewServiceImpl implements ReviewService {
    ReviewDAO reviewDAO;

    public ReviewServiceImpl() {
        reviewDAO = new ReviewDAOImpl();
    }

    @Override
    public void insertReview(Review review) throws Exception {
        reviewDAO.insertReview(review);
    }

    @Override
    public List<Review> selectedByProductNo(int productNo) throws Exception {
        return reviewDAO.selectedByProductNo(productNo);
    }

    @Override
    public double selectAvgScore(int productNo) throws Exception {
        return reviewDAO.selectAvgScore(productNo);
    }

    @Override
    public void deleteReview(Integer no) throws Exception {
        reviewDAO.deleteReview(no);
    }

    // 페이징용 추가
    @Override
    public int getReviewCount(ReviewQueryParams params) throws Exception {
        return reviewDAO.getReviewCount(params);
    }

    @Override
    public List<Review> getReviewList(ReviewQueryParams params) throws Exception {
        return reviewDAO.getReviewList(params);
    }

    @Override
    public PageInfo getReviewPageInfo(ReviewQueryParams params) throws Exception {
        int totalCount = reviewDAO.getReviewCount(params);
        int pageSize = params.getPageSize();
        int allPage = (int) Math.ceil((double) totalCount / pageSize);

        int curPage = (params.getStartRow() / pageSize) + 1;
        int startPage = ((curPage - 1) / 5) * 5 + 1;
        int endPage = Math.min(startPage + 4, allPage);
        System.out.println("[Service] PageInfo - totalCount: " + totalCount + ", allPage: " + allPage);

        PageInfo pageInfo = new PageInfo();
        pageInfo.setCurPage(curPage);
        pageInfo.setAllPage(allPage);
        pageInfo.setStartPage(startPage);
        pageInfo.setEndPage(endPage);
        pageInfo.setTotalCount(totalCount);
        pageInfo.setPageSize(pageSize);

        return pageInfo;
    }

    
	@Override
	public void updateReview(Review review) throws Exception {
		reviewDAO.updateReview(review);
	}

	@Override
	public boolean checkMyReview(Integer productNo, Integer memberNo) throws Exception {
		return reviewDAO.checkMyReview(productNo, memberNo)>0;
	}

}

