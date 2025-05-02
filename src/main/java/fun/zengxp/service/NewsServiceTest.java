package fun.zengxp.service;

import fun.zengxp.pojo.News;

import java.util.List;

public class NewsServiceTest {
    public static void main(String[] args) {
        NewsService newsService = new NewsService();
        List<News> newsList= newsService.getNewsList(1, 10);
        // 测试获取新闻列表
        System.out.println("测试获取新闻列表:");
        for (News news : newsList) {
            System.out.println(news.getNewsTitle());
        }

        // 测试通过ID获取新闻
        System.out.println("\n测试通过ID获取新闻:");
        News newsById = newsService.getNewsById(1);
        if (newsById != null) {
            System.out.println(newsById.getNewsContent());
        } else {
            System.out.println("未找到指定ID的新闻");
        }

        // 测试获取最新新闻
        System.out.println("\n测试获取最新新闻:");
        News latestNews = newsService.getNewsLatest();
        if (latestNews != null) {
            System.out.println(latestNews.getNewsContent());
        } else {
            System.out.println("未找到最新新闻");
        }

        // 测试添加新闻（需根据实际需求调整）
        // System.out.println("\n测试添加新闻:");
        // News newNews = new News();
        // newNews.setNewsTitle("测试标题");
        // newNews.setNewsContent("测试内容");
        // boolean addResult = newsService.addNews(newNews);
        // System.out.println(addResult ? "添加成功" : "添加失败");
    }
}
