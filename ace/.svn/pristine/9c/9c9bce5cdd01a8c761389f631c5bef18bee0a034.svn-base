package com.jeefw.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.google.common.base.Objects;
import com.jeefw.model.sys.param.AuthorityParameter;

/**
 * 菜单的实体类
 */
@Entity
@Table(name = "authority")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
//oracle使用seq维护主键方式     name表示申明的这个sequence的名称，sequenceName表示数据库中的那个sequence名称   两个名称的参数可以一样
//@SequenceGenerator(name="seqAuthority",sequenceName="seq_authority")
public class Authority extends AuthorityParameter {

	// 各个字段的含义请查阅文档的数据库结构部分
	private static final long serialVersionUID = -5233663741711528284L;
	@Id
	//@GeneratedValue(strategy = GenerationType.SEQUENCE,generator="seqAuthority")
	//@SequenceGenerator(name = "seqAuthority", sequenceName = "seqAuthority" ,allocationSize =1,initialValue=1)
	@GeneratedValue
	@Column(name = "id")
	private Long id;
	@Column(name = "menu_code", length = 50, nullable = false, unique = true)
	private String menuCode;
	@Column(name = "menu_name", length = 50, nullable = false)
	private String menuName;
	@Column(name = "menu_class", length = 50, nullable = false)
	private String menuClass;
	@Column(name = "data_url", length = 100, nullable = false)
	private String dataUrl;
	@Column(name = "sequence")
	private Long sequence;
	@Column(name = "parent_menucode", length = 50)
	private String parentMenuCode;

	public Authority() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuClass() {
		return menuClass;
	}

	public void setMenuClass(String menuClass) {
		this.menuClass = menuClass;
	}

	public String getDataUrl() {
		return dataUrl;
	}

	public void setDataUrl(String dataUrl) {
		this.dataUrl = dataUrl;
	}

	public Long getSequence() {
		return sequence;
	}

	public void setSequence(Long sequence) {
		this.sequence = sequence;
	}

	public String getParentMenuCode() {
		return parentMenuCode;
	}

	public void setParentMenuCode(String parentMenuCode) {
		this.parentMenuCode = parentMenuCode;
	}

	public boolean equals(Object obj) {
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Authority other = (Authority) obj;
		return Objects.equal(this.id, other.id) && Objects.equal(this.sequence, other.sequence) && Objects.equal(this.menuCode, other.menuCode) && Objects.equal(this.menuName, other.menuName)
				&& Objects.equal(this.menuClass, other.menuClass) && Objects.equal(this.dataUrl, other.dataUrl) && Objects.equal(this.parentMenuCode, other.parentMenuCode);
	}

	public int hashCode() {
		return Objects.hashCode(this.id, this.sequence, this.menuCode, this.menuName, this.menuClass, this.dataUrl, this.parentMenuCode);
	}

}
