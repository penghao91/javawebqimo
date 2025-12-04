package com.questionnaire.controller;

import com.questionnaire.model.Questionnaire;
import com.questionnaire.model.User;
import com.questionnaire.service.QuestionnaireService;
import com.questionnaire.service.StatisticsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/statistics")
public class StatisticsController {

    @Resource
    private QuestionnaireService questionnaireService;
    
    @Resource
    private StatisticsService statisticsService;

    private User getCurrentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("user");
    }

    @GetMapping("/view/{questionnaireId}")
    public String viewStatistics(@PathVariable Integer questionnaireId,
                                HttpServletRequest request,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
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