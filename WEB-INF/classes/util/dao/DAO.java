package util.dao;

import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;

public class DAO {

	// 插入，更新，删除操作都可以包含其中
	public void update(String sql, Object... args) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		try {
			connection = DBTools.getConnection();
			preparedStatement = connection.prepareStatement(sql);

			for (int i = 0; i < args.length; i++) {
				preparedStatement.setObject(i + 1, args[i]);
			}
			preparedStatement.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBTools.close(connection, preparedStatement, null);
		}
	}

	// 查询一条记录，返回对应的对象
	public <T> T get(Class<T> clazz, String sql, Object... args) {
		List<T> result = getForList(clazz, sql, args);
		if (result.size() > 0) {
			return result.get(0);
		}
		return null;
	}

	/**
	 * 传入SQL语句和class对象，查询多条记录，返回对应的对象的集合
	 * 
	 * @param clazz
	 *            对象的类型
	 * @param sql
	 *            SQL语句
	 * @param args
	 *            填充SQL语句的占位符可变参数
	 * @return 对象的集合
	 */
	public <T> List<T> getForList(Class<T> clazz, String sql, Object... args) {

		List<T> list = new ArrayList();

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			// 1. 得到结果集
			connection = DBTools.getConnection();
			preparedStatement = connection.prepareStatement(sql);

			for (int i = 0; i < args.length; i++) {
				preparedStatement.setObject(i + 1, args[i]);
			}

			resultSet = preparedStatement.executeQuery();

			// 2.处理结果集，得到Map的List，其中一个Map对象就是一条记录
			// Map的key为resultSet中的列名，value为列的值
			List<Map<String, Object>> values = handleResultSetToMapList(resultSet);

			// 3.把Map的List转为clazz对应的List集合
			// 其中Map的key即为clazz对应的propertyName
			// Map的value即为clazz对应的propertyValue
			list = transferMapListToBeanList(clazz, values);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBTools.close(connection, preparedStatement, resultSet);
		}

		return list;
	}

	public <T> List<T> transferMapListToBeanList(Class<T> clazz, List<Map<String, Object>> values) throws InstantiationException, IllegalAccessException, InvocationTargetException {
		List<T> result = new ArrayList();
		T bean = null;
		if (values.size() > 0) {
			// 遍历Map中的键值
			for (Map<String, Object> m : values) {
				bean = clazz.newInstance();
				for (Map.Entry<String, Object> entry : m.entrySet()) {
					String propertyName = entry.getKey().toLowerCase();
					Object value = entry.getValue();

					BeanUtils.setProperty(bean, propertyName, value);
				}
				// 将object对象放入list中
				result.add(bean);
			}
		}
		return result;
	}

	/**
	 * 处理结果集，得到含有Map的一个List，其中一个Map对象对应一条记录
	 * 
	 * @param resultSet
	 * @return
	 * @throws SQLException
	 */
	public List<Map<String, Object>> handleResultSetToMapList(ResultSet resultSet) throws SQLException {
		List<Map<String, Object>> values = new ArrayList();

		List<String> columnLabels = getColumnLabels(resultSet);
		Map<String, Object> map = null;

		// 处理ResultSet，使用while循环
		while (resultSet.next()) {
			map = new HashMap();

			for (String columnLabel : columnLabels) {
				Object value = resultSet.getObject(columnLabel); // 获得列的值

				map.put(columnLabel, value); // 将列的别名与列的值放入map集合中
			}
			values.add(map); // 将map集合放入List中
		}
		return values;
	}

	/**
	 * 获取结果集的ColumnLabel对应的List
	 * 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	public List<String> getColumnLabels(ResultSet rs) throws SQLException {
		List<String> labels = new ArrayList();
		ResultSetMetaData rsmd = rs.getMetaData();
		for (int i = 0; i < rsmd.getColumnCount(); i++) {
			labels.add(rsmd.getColumnLabel(i + 1));
		}
		return labels;
	}

	// 返回某条记录的某个字段的值或一个统计的值
	public <E> E getForValue(String sql, Object... args) {

		// 1.得到结果集：该结果集只有一行，一列
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		try {
			connection = DBTools.getConnection();
			preparedStatement = connection.prepareStatement(sql);

			for (int i = 0; i < args.length; i++) {
				preparedStatement.setObject(i + 1, args[i]);
			}

			resultSet = preparedStatement.executeQuery();

			if (resultSet.next()) {
				return (E) resultSet.getObject(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBTools.close(connection, preparedStatement, resultSet);
		}
		return null;
	}
}