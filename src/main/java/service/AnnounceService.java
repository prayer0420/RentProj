package service;

import java.util.List;

import dto.Announce;

public interface AnnounceService {
    boolean createAnnounce(Announce announce) throws Exception ;
    boolean updateAnnounce(Announce announce) throws Exception ;
    boolean deleteAnnounces(List<Integer> noList) throws Exception ;
    Announce getAnnounceByNo(int no) throws Exception ;
    List<Announce> getAllAnnounces() throws Exception ;
    
}