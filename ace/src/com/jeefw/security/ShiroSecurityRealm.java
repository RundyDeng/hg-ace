package com.jeefw.security;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authc.credential.Sha256CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.jeefw.dao.sys.SysUserDao;
import com.jeefw.model.sys.Role;
import com.jeefw.model.sys.SysUser;

@Component
public class ShiroSecurityRealm extends AuthorizingRealm {

	private final static Logger LOG = LoggerFactory.getLogger(ShiroSecurityRealm.class);
	public final static String REALM_NAME = "ShiroSecurityRealm";

	
	@Resource
	private SysUserDao sysUserDao;

	public ShiroSecurityRealm() {
		setName(REALM_NAME); // This name must match the name in the SysUser class's getPrincipals() method
		setCredentialsMatcher(new Sha256CredentialsMatcher());
	}

	//认证
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		SysUser user = sysUserDao.getByProerties("userName", token.getUsername());  //emial 9/18
		
		if(LOG.isTraceEnabled()){
			LOG.trace("开始认证：" + user.getUserName());
		}
	
		if (user != null) {
			return new SimpleAuthenticationInfo(user.getId(), user.getPassword(), getName());
		} else {
			return null;
		}
	}

	//授权
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Long userId = (Long) principals.fromRealm(getName()).iterator().next();
		SysUser user = sysUserDao.get(userId);
		if(LOG.isTraceEnabled()){
			LOG.trace("开始授权 "+ user.getUserName());
		}
		
		if (user != null) {
			SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
			for (Role role : user.getRoles()) {
				info.addRole(role.getRoleKey());
				info.addStringPermissions(role.getPermissions());
			}
			return info;
		} else {
			return null;
		}
	}

}
