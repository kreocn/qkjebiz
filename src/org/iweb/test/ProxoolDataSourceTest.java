package org.iweb.test;

import java.sql.Connection;
import java.util.Hashtable;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.Reference;
import javax.naming.StringRefAddr;
import javax.naming.spi.NamingManager;
import javax.sql.DataSource;

import org.logicalcobwebs.proxool.ConnectionPoolDefinitionIF;
import org.logicalcobwebs.proxool.ProxoolConstants;
import org.logicalcobwebs.proxool.ProxoolDataSource;
import org.logicalcobwebs.proxool.ProxoolFacade;

public class ProxoolDataSourceTest {

	public ProxoolDataSourceTest(String alias) {
		// super(alias);
		Connection conn = null;
		//conn.prepareStatement(sql);
	}

	/**
	 * Test the Proxool managed DataSource
	 * 关于java.naming.factory.initial
	 * Tomcat 用org.apache.naming.java.javaURLContextFactory
	 * 
	 */
	public void testPreconfiguredDataSource() throws Exception {
		String alias = "preconfiguredDatasourceTest";
		String jndiName = "TestDB";
		String url = "";
		// TestHelper.buildProxoolUrl(alias, TestConstants.HYPERSONIC_DRIVER,TestConstants.HYPERSONIC_TEST_URL);
		Properties info = new Properties();
		info.setProperty(ProxoolConstants.USER_PROPERTY, ""); // TestConstants.HYPERSONIC_USER
		info.setProperty(ProxoolConstants.PASSWORD_PROPERTY, ""); // TestConstants.HYPERSONIC_PASSWORD
		info.setProperty(ProxoolConstants.JNDI_NAME_PROPERTY, jndiName);
		info.setProperty(ProxoolConstants.JNDI_PROPERTY_PREFIX + "java.naming.factory.initial",org.apache.naming.java.javaURLContextFactory.class.getName());
		info.setProperty(ProxoolConstants.JNDI_PROPERTY_PREFIX + "java.naming.factory.url.pkgs", "tyrex.naming");
		info.setProperty(ProxoolConstants.JNDI_PROPERTY_PREFIX + "java.naming.provider.url", "localhost:8888");
		ProxoolFacade.registerConnectionPool(url, info);

		Hashtable env = new Hashtable();
		env.put(Context.INITIAL_CONTEXT_FACTORY, ""); // MemoryContextFactory.class.getName()
		env.put(Context.URL_PKG_PREFIXES, "tyrex.naming");
		env.put(Context.PROVIDER_URL, alias);
		Context context = new InitialContext(env);
		DataSource dataSource = (DataSource) context.lookup(jndiName);
		// assertNotNull("Connection was null.", dataSource.getConnection());
		ProxoolFacade.removeConnectionPool(alias);
		context.close();
		//org.apache.naming.Constants
	}
	
	//java.naming.factory.initial=org.apache.naming.java.javaURLContextFactory   
	//java.naming.factory.url.pkgs=org.apache.naming   
	//java.naming.factory.url.pkgs.prefixes=org.apache.naming   
	//java.naming.provider.url=org.apache.naming 

	/**
	 * Test the bean configured DataSource.
	 */
	public void testBeanConfiguredDataSource() throws Exception {
		String alias = "beanConfiguredDataSourceTest";
		String jndiName = "jdbc/beanConfiguredTestDB";

		// pretend to be a J2EE server that instantites the data source
		// populates its properties and binds it to JNDI
		ProxoolDataSource dataSource = new ProxoolDataSource();
		dataSource.setAlias(alias);
		dataSource.setDriver(""); // TestConstants.HYPERSONIC_DRIVER
		dataSource.setDriverUrl(""); // TestConstants.HYPERSONIC_TEST_URL
		dataSource.setUser(""); // TestConstants.HYPERSONIC_USER
		dataSource.setPassword(""); // TestConstants.HYPERSONIC_PASSWORD
		dataSource.setDelegateProperties("dummy=foo,anotherDummy=bar");

		Hashtable env = new Hashtable();
		// env.put(Context.INITIAL_CONTEXT_FACTORY, MemoryContextFactory.class.getName());
		env.put(Context.URL_PKG_PREFIXES, "tyrex.naming");
		env.put(Context.PROVIDER_URL, alias);
		Context context = new InitialContext(env);
		context.createSubcontext("jdbc");
		context.bind(jndiName, dataSource);
		context.close();
		// end J2EE server

		// now... pretend to be a client.
		context = new InitialContext(env);
		DataSource clientDataSource = (DataSource) context.lookup(jndiName);
		// assertNotNull("Connection was null.", clientDataSource.getConnection());

		ConnectionPoolDefinitionIF cpd = ProxoolFacade.getConnectionPoolDefinition(alias);
		// assertEquals("dummy", "foo", cpd.getDelegateProperty("dummy"));
		// assertEquals("dummy", "bar", cpd.getDelegateProperty("anotherDummy"));

		ProxoolFacade.removeConnectionPool(alias);
		context.close();
	}

	/**
	 * Test the bean configured DataSource.
	 */
	public void testFactoryConfiguredDataSource() throws Exception {
		String alias = "factoryConfiguredDataSourceTest";
		String jndiName = "jdbc/factoryConfiguredTestDB";

		Reference reference = new Reference(ProxoolDataSource.class.getName(), ProxoolDataSource.class.getName(),
				null);
		reference.add(new StringRefAddr(ProxoolConstants.ALIAS_PROPERTY, alias));
		reference.add(new StringRefAddr(ProxoolConstants.DRIVER_CLASS_PROPERTY, "")); // TestConstants.HYPERSONIC_DRIVER
		reference.add(new StringRefAddr(ProxoolConstants.DRIVER_URL_PROPERTY, "")); // TestConstants.HYPERSONIC_TEST_URL
		reference.add(new StringRefAddr(ProxoolConstants.USER_PROPERTY, "")); // TestConstants.HYPERSONIC_USER
		reference.add(new StringRefAddr(ProxoolConstants.PASSWORD_PROPERTY, "")); // TestConstants.HYPERSONIC_PASSWORD
		reference.add(new StringRefAddr("dummy", "foo"));
		reference.add(new StringRefAddr("anotherDummy", "bar"));

		// pretend to be a JNDI aware container that builds the DataSource
		// using its factory
		Hashtable env = new Hashtable();
		// env.put(Context.INITIAL_CONTEXT_FACTORY, MemoryContextFactory.class.getName());
		env.put(Context.URL_PKG_PREFIXES, "tyrex.naming");
		env.put(Context.PROVIDER_URL, alias);
		Context context = new InitialContext(env);
		context.createSubcontext("jdbc");
		context.bind(jndiName, NamingManager.getObjectInstance(reference, null, null, null));
		context.close();
		// end JNDI aware container

		// now... pretend to be a client.
		context = new InitialContext(env);
		DataSource clientDataSource = (DataSource) context.lookup(jndiName);
		// assertNotNull("Connection was null.", clientDataSource.getConnection());

		ConnectionPoolDefinitionIF cpd = ProxoolFacade.getConnectionPoolDefinition(alias);
		// assertEquals("dummy", "foo", cpd.getDelegateProperty("dummy"));
		// assertEquals("dummy", "bar", cpd.getDelegateProperty("anotherDummy"));

		ProxoolFacade.removeConnectionPool(alias);
		context.close();
	}

}
