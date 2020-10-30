package com.skilldistillery.winenot.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Wine {
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY)
	private int id;
	
	private String vineyeard;
	@Column(name = "vintage_year")
	private Integer vintageYear;
	
	private String flavor;
	
	private String dietary;
	
	private String description;
	
	private String image;
	
	private String pairs;

	public Wine() {
		super();
	}

	public Wine(int id, String vineyeard, Integer vintageYear, String flavor, String dietary, String description,
			String image, String pairs) {
		super();
		this.id = id;
		this.vineyeard = vineyeard;
		this.vintageYear = vintageYear;
		this.flavor = flavor;
		this.dietary = dietary;
		this.description = description;
		this.image = image;
		this.pairs = pairs;
	}

	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getVineyeard() {
		return vineyeard;
	}

	public void setVineyeard(String vineyeard) {
		this.vineyeard = vineyeard;
	}

	public Integer getVintageYear() {
		return vintageYear;
	}

	public void setVintageYear(Integer vintageYear) {
		this.vintageYear = vintageYear;
	}

	public String getFlavor() {
		return flavor;
	}

	public void setFlavor(String flavor) {
		this.flavor = flavor;
	}

	public String getDietary() {
		return dietary;
	}

	public void setDietary(String dietary) {
		this.dietary = dietary;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPairs() {
		return pairs;
	}

	public void setPairs(String pairs) {
		this.pairs = pairs;
	}

	@Override
	public String toString() {
		return "Wine [id=" + id + ", vineyeard=" + vineyeard + ", vintageYear=" + vintageYear + ", flavor=" + flavor
				+ ", dietary=" + dietary + ", description=" + description + ", image=" + image + ", pairs=" + pairs
				+ "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Wine other = (Wine) obj;
		if (id != other.id)
			return false;
		return true;
	}
	
	
	

}
