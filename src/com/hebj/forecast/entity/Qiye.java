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

public class Qiye {

	/**
	 * 企业站点资料
	 * 
	 * @author hebj
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	private String group;
	private String name;
	private double longitude;
	private double latitude;
	private String city;
	private double alt;
	private String linkper;
	private String phone;
	private String product;
	private String description;
	private String address;

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Qiye [id=" + id + ", group=" + group + ", name=" + name + ", longitude=" + longitude + ", latitude="
				+ latitude + ", city=" + city + ", alt=" + alt + ", linkper=" + linkper + ", phone=" + phone
				+ ", product=" + product + ", description=" + description + "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
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

	public String getLinkper() {
		return linkper;
	}

	public void setLinkper(String linkper) {
		this.linkper = linkper;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}