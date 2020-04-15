package com.jeefw.service.sys;

import com.jeefw.model.sys.Role;

import core.service.Service;

public interface RoleService extends Service<Role> {

	// 删除角色
	void deleteSysUserAndRoleByRoleId(Long roleId);

}
