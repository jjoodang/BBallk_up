package com.gdj37.bballkup.web.notice.service;

import java.util.HashMap;
import java.util.List;

public interface INoticeService {

	public int getNoticeCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getNoticeList(HashMap<String, String> params) throws Throwable;

	public void updateNoticeHit(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getNotice(HashMap<String, String> params) throws Throwable;

	public int NoticeAdd(HashMap<String, String> params) throws Throwable;

	public int NoticeUpdate(HashMap<String, String> params) throws Throwable;

	public int NoticeDeletes(HashMap<String, String> params) throws Throwable;

}
