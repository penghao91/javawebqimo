package com.questionnaire.controller;

import com.questionnaire.model.Questionnaire;
import com.questionnaire.model.User;
import com.questionnaire.service.QuestionnaireService;
import com.questionnaire.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {

    @Autowired
    private QuestionnaireService questionnaireService;
    
    @Autowired
    private StatisticsService statisticsService;

    @GetMapping("/view/{questionnaireId}")
    public String viewStatistics(@PathVariable Integer questionnaireId,
                                @AuthenticationPrincipal User user,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        
        Questionnaire questionnaire = questionnaireService.findById(questionnaireId);
        
        if (questionnaire == null) {
            redirectAttributes.addFlashAttribute("error", "问卷不存在！");
            return "redirect:/questionnaire/list";
        }
        
        if (!questionnaire.getCreatedBy().equals(user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权查看此问卷的统计！");
            return "redirect:/questionnaire/list";
        }
        
        Map<String, Object> statistics = statisticsService.getQuestionnaireStatistics(questionnaireId);
        
        model.addAttribute("questionnaire", questionnaire);
        model.addAttribute("statistics", statistics);
        
        return "statistics/view";
    }
}
