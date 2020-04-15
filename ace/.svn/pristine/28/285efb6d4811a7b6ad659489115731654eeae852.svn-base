package com.jeefw.model.haskey;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.jeefw.model.haskey.param.FileListsParamter;
/**
 * CREATE TABLE FileLists
(
FileListID NUMBER(19) NOT NULL,
UserAccount VARCHAR2(100),   --上传者
Contactor VARCHAR2(100),
UpFileName VARCHAR2(100),
FileContent VARCHAR2(1000),
FileSize VARCHAR2(100),
FileType VARCHAR2(100),
FileClasses VARCHAR2(1000),  --文件说明
DownloadTimes NUMBER(4),
AddTime DATE,
leixin VARCHAR2(100),
filePath varchar2(1000),
PRIMARY KEY (FileListID)
);
 * @author ZQ
 */

@Entity
@Table(name="newFilelists")
//@Cache(region="all",usage = CacheConcurrencyStrategy.READ_WRITE)
//@JsonIgnoreProperties(value = { "maxResults", "firstResult", "topCount", "sortColumns", "cmd", "queryDynamicConditions", "sortedConditions", "dynamicProperties", "success", "message", "sortColumnsString", "flag" })
public class FileLists extends FileListsParamter {

	private static final long serialVersionUID = 9116219724560866256L;
	@Id	
	@GeneratedValue
	@Column(name="file_list_id")
	private Long fileListId;
	@Column(name="user_account",length=100)
	private String userAccount;
	@Column(name="contactor",length=100)
	private String contactor;
	@Column(name="up_file_name",length=250)
	private String upFileName;
	@Column(name="file_content",length=2200)
	private String fileContent;
	@Column(name="file_size",length=250)
	private String fileSize;
	@Column(name="file_type",length=100)
	private String fileType;
	@Column(name="file_classes",length=1000)
	private String fileClasses;
	@Column(name="download_times")
	private int downloadTimes;
	@Column(name="add_time")
	@Temporal(TemporalType.TIMESTAMP)
	private Date addTime;
	@Column(name="leixing",length=100)
	private String leixing;
	@Column(name="file_path",length=1000)
	private String filePath;
	
	public FileLists(){
		
	}
	
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Long getFileListId() {
		return fileListId;
	}
	public void setFileListId(Long fileListId) {
		this.fileListId = fileListId;
	}
	public String getUserAccount() {
		return userAccount;
	}
	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
	public String getContactor() {
		return contactor;
	}
	public void setContactor(String contactor) {
		this.contactor = contactor;
	}
	public String getUpFileName() {
		return upFileName;
	}
	public void setUpFileName(String upFileName) {
		this.upFileName = upFileName;
	}
	public String getFileContent() {
		return fileContent;
	}
	public void setFileContent(String fileContent) {
		this.fileContent = fileContent;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileClasses() {
		return fileClasses;
	}
	public void setFileClasses(String fileClasses) {
		this.fileClasses = fileClasses;
	}
	public int getDownloadTimes() {
		return downloadTimes;
	}
	public void setDownloadTimes(int downloadTimes) {
		this.downloadTimes = downloadTimes;
	}
	public Date getAddTime() {
		return addTime;
	}
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	public String getLeixing() {
		return leixing;
	}
	public void setLeixing(String leixing) {
		this.leixing = leixing;
	}
	
	
}
