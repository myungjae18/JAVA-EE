package com.itbank.model.repository;

import java.util.List;

import com.itbank.model.domain.Member;

//이 인터페이스의 목적
//(1)어떤 종류의 DAO건 이 인터페이스에 명시된 메서드는 반드시 
//		구현할 강제를 주기 위함
//(2)자료형을 통일할 수 있어서 코드가 유연해진다
public interface MemberDAO {
	//CRUD
	public int insert(Member member);
	public List selectAll();
	public Member select(int member_id);
	public int update(Member member);
	public int delete(int member_id);
	
}






















