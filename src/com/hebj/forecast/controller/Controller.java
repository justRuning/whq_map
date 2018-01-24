//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永无BUG
//
//
//

package com.hebj.forecast.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.hebj.forecast.entity.Qiye;
import com.hebj.forecast.entity.Station;
import com.hebj.forecast.entity.Weather;

@org.springframework.stereotype.Controller
@RequestMapping("/")
public class Controller {

	/**
	 * 首页
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public ModelAndView index() {

		List<Station> stations = getStations();
		List<Weather> weathers = getWeather(stations);
		ModelAndView model = new ModelAndView("weather.jsp");

		model.addObject("weathers", weathers);

		return model;
	}

	@RequestMapping("/qiye")
	public ModelAndView qiye() {

		List<Qiye> qiyes = getQiyes();
		ModelAndView model = new ModelAndView("qiye.jsp");

		model.addObject("qiyes", qiyes);

		return model;
	}

	public List<Weather> getWeather(List<Station> stations) {

		String params = "";
		List<Weather> weathers = new ArrayList<Weather>();
		WebsUtil websUtil = new WebsUtil();
		String rstData = "";
		JSONArray objects = new JSONArray();
		String ids = "";
		DateFormat dFormat = new SimpleDateFormat("yyyyMMddHH0000");
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.MINUTE, -(8 * 60 + 10));

		for (Station station : stations) {
			ids = ids + station.getNum() + ",";
		}
		String lastTime = dFormat.format(calendar.getTime());
		try {

			params = "userId=BEHT_BFLH_hebj" + "&pwd=123123" + "&interfaceId=getSurfEleByTimeAndStaID"
					+ "&dataCode=SURF_CHN_MUL_HOR_R" + "&elements=Station_Id_C,TEM,RHU,WIN_D_Avg_2mi,WIN_S_Avg_2mi,GST"
					+ "&times=" + lastTime + "&limitCnt=30" + "&staIds=" + ids + "&dataFormat=json";
			rstData = websUtil.getWsString("callAPI_to_serializedStr", params);
			JSONObject jsonObject = new JSONObject(rstData);
			objects = jsonObject.getJSONArray("DS");

		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		for (int i = 0; i < objects.length(); i++) {
			try {
				String object = (String) objects.getJSONObject(i).get("Station_Id_C");
				Weather weather = new Weather();
				weather.setStation(getStationById(stations, object));
				String string = (String) objects.getJSONObject(i).get("TEM");
				weather.setTem(string.equals("999999") ? "" : string + "℃");
				string = (String) objects.getJSONObject(i).get("RHU");
				weather.setRelativeHumidity((string.equals("999999") ? "" : string + "%"));
				string = (String) objects.getJSONObject(i).get("WIN_D_Avg_2mi");
				weather.setWindDirection2min((string.equals("999999") ? "" : string));
				string = (String) objects.getJSONObject(i).get("WIN_S_Avg_2mi");
				weather.setWindVelocity2min((string.equals("999999") ? "" : string + "m/s"));
				string = (String) objects.getJSONObject(i).get("GST");
				weather.setSurfaceTemp((string.equals("999999") ? "" : string + "℃"));
				weathers.add(weather);
				object = null;
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return weathers;
	}

	public Station getStationById(List<Station> stations, String id) {
		for (Station station : stations) {
			if (station.getNum().equals(id)) {
				return station;
			}
		}
		return null;
	}

	/**
	 * 获取自动站基本数据
	 * 
	 * @return
	 */
	public List<Station> getStations() {
		// JDBC 驱动名及数据库 URL
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		String DB_URL = "jdbc:mysql://172.18.132.2:3306/whqgkqy";
		List<Station> stations = new ArrayList<Station>();
		// 数据库的用户名与密码，需要根据自己的设置
		String USER = "whqqxj";
		String PASS = "53513";

		Connection conn = null;
		Statement stmt = null;
		try {
			// 注册 JDBC 驱动
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			stmt = conn.createStatement();
			String sql;
			sql = "SELECT t_area, t_name, t_num,t_lon,t_lat,t_alt FROM zdzdcs";
			ResultSet rs = stmt.executeQuery(sql);

			// 展开结果集数据库
			while (rs.next()) {
				Station station = new Station();
				// 通过字段检索
				station.setCity(rs.getString("t_area"));
				station.setName(rs.getString("t_name"));
				station.setNum(rs.getString("t_num"));
				station.setLatitude(rs.getDouble("t_lat"));
				station.setLongitude(rs.getDouble("t_lon"));
				station.setAlt(rs.getDouble("t_alt"));

				stations.add(station);

			}
			// 完成后关闭
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException se) {
			// 处理 JDBC 错误
			se.printStackTrace();
		} catch (Exception e) {
			// 处理 Class.forName 错误
			e.printStackTrace();
		} finally {
			// 关闭资源
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			} // 什么都不做
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return stations;

	}

	/**
	 * 获取自动站基本数据
	 * 
	 * @return
	 */
	public List<Qiye> getQiyes() {
		// JDBC 驱动名及数据库 URL
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		String DB_URL = "jdbc:mysql://172.18.132.2:3306/whqgkqy";
		List<Qiye> qiyes = new ArrayList<Qiye>();
		// 数据库的用户名与密码，需要根据自己的设置
		String USER = "whqqxj";
		String PASS = "53513";

		Connection conn = null;
		Statement stmt = null;
		try {
			// 注册 JDBC 驱动
			Class.forName("com.mysql.jdbc.Driver");

			conn = DriverManager.getConnection(DB_URL, USER, PASS);

			stmt = conn.createStatement();
			String sql;
			sql = "SELECT * FROM t_qiyeinfo";
			ResultSet rs = stmt.executeQuery(sql);

			// 展开结果集数据库
			while (rs.next()) {
				Qiye qiye = new Qiye();
				// 通过字段检索
				qiye.setCity(rs.getString("nickname"));
				qiye.setName(rs.getString("qyname"));
				qiye.setPhone(rs.getString("phon"));
				qiye.setLatitude(rs.getDouble("weidu"));
				qiye.setLongitude(rs.getDouble("jingdu"));
				qiye.setAlt(rs.getDouble("haiba"));
				qiye.setAddress(rs.getString("weizhi"));
				qiye.setLinkper(rs.getString("linkper"));
				qiye.setDescription(rs.getString("synopsis"));
				qiye.setGroup(rs.getString("qyClass"));

				qiyes.add(qiye);

			}
			// 完成后关闭
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException se) {
			// 处理 JDBC 错误
			se.printStackTrace();
		} catch (Exception e) {
			// 处理 Class.forName 错误
			e.printStackTrace();
		} finally {
			// 关闭资源
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException se2) {
			} // 什么都不做
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return qiyes;

	}

}
