package com.hebj.forecast.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.context.annotation.Lazy;

/**
 * @author hebj
 *
 */

public class Station {

	/**
	 * 观测站点资料
	 * 
	 * @author hebj
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	private String num;
	private String name;
	private double longitude;
	private double latitude;
	private String city;
	private double alt;

	@Override
	public String toString() {
		return "Station [id=" + id + ", num=" + num + ", name=" + name + ", longitude=" + longitude + ", latitude="
				+ latitude + ", city=" + city + ", alt=" + alt + "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public double getAlt() {
		return alt;
	}

	public void setAlt(double alt) {
		this.alt = alt;
	}

}