package com.questionnaire.scheduler;

import com.questionnaire.service.QuestionnaireService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class AutoDeleteScheduler {
    
    @Autowired
    private QuestionnaireService questionnaireService;
    
    // 每天凌晨2点执行一次自动删除任务（删除30天前的回收站问卷）
    @Scheduled(cron = "0 0 2 * * ?")
    public void autoDeleteExpiredQuestionnaires() {
        // 删除30天前的回收站问卷
        questionnaireService.autoDeleteExpired(30);
    }
    
    // 每小时执行一次测试（调试用，可以注释掉）
    // @Scheduled(cron = "0 0 * * * ?")
    // public void hourlyDeleteCheck() {
    //     questionnaireService.autoDeleteExpired(30);
    // }
}