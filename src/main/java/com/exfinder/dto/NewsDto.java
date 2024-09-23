package com.exfinder.dto;

public class NewsDto {
    private String newsIcon;
    private String newsName;
    private String newsTime;
    private String newsURL;
    private String newsTitle;
    private String newsText;
    private String newsImg;
    
	@Override
	public String toString() {
		return "NewsDto [newsIcon=" + newsIcon + ", newsName=" + newsName + ", newsTime=" + newsTime + ", newsURL="
				+ newsURL + ", newsTitle=" + newsTitle + ", newsText=" + newsText + ", newsImg=" + newsImg + "]";
	}

	public String getNewsIcon() {
		return newsIcon;
	}
	public void setNewsIcon(String newsIcon) {
		this.newsIcon = newsIcon;
	}

	public String getNewsName() {
		return newsName;
	}
	public void setNewsName(String newsName) {
		this.newsName = newsName;
	}

	public String getNewsTime() {
		return newsTime;
	}
	public void setNewsTime(String newsTime) {
		this.newsTime = newsTime;
	}

	public String getNewsURL() {
		return newsURL;
	}
	public void setNewsURL(String newsURL) {
		this.newsURL = newsURL;
	}

	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}

	public String getNewsText() {
		return newsText;
	}
	public void setNewsText(String newsText) {
		this.newsText = newsText;
	}

	public String getNewsImg() {
		return newsImg;
	}
	public void setNewsImg(String newsImg) {
		this.newsImg = newsImg;
	}

    
}
