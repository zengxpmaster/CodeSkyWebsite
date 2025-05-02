package fun.zengxp.pojo;

import java.time.LocalDateTime;

public class News {
    private int newsId;
    private String newsTitle;
    private String newsContent;
    private String newsAuthor;
    private LocalDateTime newsTime;

    public News()
    {

    }

    public News(int newsId, String newsTitle, String newsContent, String newsAuthor, LocalDateTime newsTime) {
        this.newsId = newsId;
        this.newsTitle = newsTitle;
        this.newsContent = newsContent;
        this.newsAuthor = newsAuthor;
        this.newsTime = newsTime;
    }

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getNewsTitle() {
        return newsTitle;
    }

    public void setNewsTitle(String newsTitle) {
        this.newsTitle = newsTitle;
    }

    public String getNewsContent() {
        return newsContent;
    }

    public void setNewsContent(String newsContent) {
        this.newsContent = newsContent;
    }

    public String getNewsAuthor() {
        return newsAuthor;
    }

    public void setNewsAuthor(String newsAuthor) {
        this.newsAuthor = newsAuthor;
    }

    public LocalDateTime getNewsTime() {
        return newsTime;
    }

    public void setNewsTime(LocalDateTime newsTime) {
        this.newsTime = newsTime;
    }
}
