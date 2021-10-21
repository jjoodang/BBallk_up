package com.gdj37.bballkup.web.login.dao;

import java.util.HashMap;

public interface ILoginDao {

	public HashMap<String, String> getLogin(HashMap<String, String> params) throws Throwable;

	public int getMemIdCheck(HashMap<String, String> params) throws Throwable;

	public int joinMem(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMem(HashMap<String, String> params) throws Throwable;

	public int updateMem(HashMap<String, String> params) throws Throwable;

	public int deleteMem(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getMainNotice(HashMap<String, String> params) throws Throwable;

}