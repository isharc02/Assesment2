package com.model;

import java.sql.Timestamp;

public class BlogsModel 
{
	private int id,uid;
	private String title,context,tags;
	
	private Timestamp createdat;

	
	private String name;

	public String getName() {
	    return name;
	}

	public void setName(String name) {
	    this.name = name;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	public Timestamp getCreatedat() {
	    return createdat;
	}

	public void setCreatedat(Timestamp createdat) {
	    this.createdat = createdat;
	}
}
	
	

