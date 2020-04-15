package com.jeefw.model.common;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the DICT database table.
 * 
 */
@Entity
@NamedQuery(name="Dict.findAll", query="SELECT d FROM Dict d")
public class Dict implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Column(name="DICT_KEY")
	private String dictKey;

	@Column(name="DICT_VALUE")
	private String dictValue;

	@Column(name="PARENT_DICTKEY")
	private String parentDictkey;

	@Column(name="\"SEQUENCE\"")
	private BigDecimal sequence;

	public Dict() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDictKey() {
		return this.dictKey;
	}

	public void setDictKey(String dictKey) {
		this.dictKey = dictKey;
	}

	public String getDictValue() {
		return this.dictValue;
	}

	public void setDictValue(String dictValue) {
		this.dictValue = dictValue;
	}

	public String getParentDictkey() {
		return this.parentDictkey;
	}

	public void setParentDictkey(String parentDictkey) {
		this.parentDictkey = parentDictkey;
	}

	public BigDecimal getSequence() {
		return this.sequence;
	}

	public void setSequence(BigDecimal sequence) {
		this.sequence = sequence;
	}

}