package com.kh.magicpot.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.magicpot.member.model.dao.MemberDao;
import com.kh.magicpot.member.model.vo.Address;
import com.kh.magicpot.member.model.vo.Member;

@Service 
public class MemberServiceImpl implements MemberService {


	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao mDao;

	@Override
	public Member loginMember(Member m) {
		return mDao.loginMember(sqlSession, m);
	}

	
	// 아이디 중복체크
	@Override
	public int idCheck(String userId) {
		return mDao.idCheck(sqlSession, userId);
	}

	// 회원가입
	@Override
	public int insertMember(Member m) {
		return mDao.insertMember(sqlSession, m);
	}

	// 배송지조회
	@Override
	public ArrayList<Address> selectMember(int memNo) {
		return mDao.selectMember(sqlSession, memNo);
	}
	
	// 회원정보수정
	@Override
	public int updateMember(Member m) {
		return mDao.updateMember(sqlSession, m);
	}

	// 배송지추가
	@Override
	public int insertAddress(HashMap<String, Object> map) {
		return mDao.insertAddress(sqlSession, map);
	}

	@Override
	public Address selectDefault(int memNo) {
		return mDao.selectDefault(sqlSession, memNo);
	}

	@Override
	public Address selectAddress(int adNo) {
		return mDao.selectAddress(sqlSession, adNo);
	}


	@Override
	public int fixAddress(Address a) {
		return mDao.fixAddress(sqlSession, a);
	}


	@Override
	public int deleteAddress(int adNo) {
		return mDao.deleteAddress(sqlSession, adNo);
	}


	@Override
	public int fixAddress2(Address a) {
		return mDao.fixAddress2(sqlSession, a);
	}
	
	@Override
	public int fixAddress3(Address a) {
		return mDao.fixAddress3(sqlSession, a);
	}




	
	


	
	

	
	
	
}
