package com.questionnaire.controller;

import com.questionnaire.model.Folder;
import com.questionnaire.model.Question;
import com.questionnaire.model.Questionnaire;
import com.questionnaire.model.User;
import com.questionnaire.service.FolderService;
import com.questionnaire.service.QuestionService;
import com.questionnaire.service.QuestionnaireService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/questionnaire")
public class QuestionnaireController {

    @Resource
    private QuestionnaireService questionnaireService;
    
    @Resource
    private QuestionService questionService;
    
    @Resource
    private FolderService folderService;

    private User getCurrentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("user");
    }

    @GetMapping("/list")
    public String list(@RequestParam(required = false) Integer folderId,
                       HttpServletRequest request, Model model) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        List<Questionnaire> questionnaires;
        
        if (folderId != null) {
            // 如果指定了folderId，显示该文件夹的问卷
            questionnaires = questionnaireService.findByFolderId(folderId);
            Folder folder = folderService.getFolderById(folderId);
            if (folder != null) {
                model.addAttribute("pageTitle", folder.getName() + " - 问卷列表");
            } else {
                model.addAttribute("pageTitle", "文件夹问卷");
            }
        } else if (user.getRole().equals("admin") || user.getRole().equals("administrator")) {
            questionnaires = questionnaireService.findAll();
            model.addAttribute("pageTitle", "问卷列表");
        } else {
            questionnaires = questionnaireService.findActiveByUserId(user.getId());
            model.addAttribute("pageTitle", "问卷列表");
        }
        
        model.addAttribute("questionnaires", questionnaires);
        return "questionnaire/list";
    }
    
    @GetMapping("/starred")
    public String starred(HttpServletRequest request, Model model) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        List<Questionnaire> questionnaires;
        
        if (user.getRole().equals("admin") || user.getRole().equals("administrator")) {
            // 管理员查看所有星标问卷
            questionnaires = questionnaireService.findAllStarred();
        } else {
            // 普通用户只查看自己的星标问卷
            questionnaires = questionnaireService.findStarredByUserId(user.getId());
        }
        
        model.addAttribute("questionnaires", questionnaires);
        model.addAttribute("pageTitle", "星标问卷");
        return "questionnaire/list";
    }
    
    @GetMapping("/recycle")
    public String recycle(HttpServletRequest request, Model model) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        List<Questionnaire> questionnaires;
        
        if (user.getRole().equals("admin") || user.getRole().equals("administrator")) {
            // 管理员查看所有已删除的问卷
            questionnaires = questionnaireService.findAllDeleted();
        } else {
            // 普通用户只查看自己已删除的问卷
            questionnaires = questionnaireService.findDeletedByUserId(user.getId());
        }
        
        model.addAttribute("questionnaires", questionnaires);
        model.addAttribute("pageTitle", "回收站");
        return "questionnaire/list";
    }
    
    @GetMapping("/folders")
    public String folders(HttpServletRequest request, Model model) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        model.addAttribute("pageTitle", "文件夹管理");
        return "questionnaire/folders";
    }
    
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("questionnaire", new Questionnaire());
        return "questionnaire/form";
    }
    
    @PostMapping("/create")
    public String create(HttpServletRequest request, 
                        @ModelAttribute Questionnaire questionnaire,
                        RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        questionnaire.setCreatedBy(user.getId());
        questionnaire.setStatus(1); // 草稿状态

        // 如果问卷没有指定文件夹，自动归类到默认文件夹
        if (questionnaire.getFolderId() == null) {
            Folder defaultFolder = folderService.findDefaultFolder(user.getId());
            // 如果默认文件夹不存在，则创建一个
            if (defaultFolder == null) {
                defaultFolder = new Folder();
                defaultFolder.setName("未分类");
                defaultFolder.setParentId(null); // 根目录
                folderService.createFolder(defaultFolder, user);
                // 再次获取以确保ID被填充
                defaultFolder = folderService.findDefaultFolder(user.getId());
            }
            if (defaultFolder != null) {
                questionnaire.setFolderId(defaultFolder.getId());
            }
        }
        
        if (questionnaireService.create(questionnaire)) {
            // 创建成功后，重定向到设计页面
            redirectAttributes.addFlashAttribute("message", "问卷创建成功！现在您可以开始设计问卷内容。");
            return "redirect:/questionnaire/design/" + questionnaire.getId();
        } else {
            redirectAttributes.addFlashAttribute("error", "问卷创建失败！");
            return "redirect:/questionnaire/create";
        }
    }
    
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, 
                          HttpServletRequest request,
                          Model model,
                          RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        Questionnaire questionnaire = questionnaireService.findById(id);
        
        if (questionnaire == null) {
            redirectAttributes.addFlashAttribute("error", "问卷不存在！");
            return "redirect:/questionnaire/list";
        }
        
        if (!questionnaire.getCreatedBy().equals(user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权编辑此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        model.addAttribute("questionnaire", questionnaire);
        return "questionnaire/form";
    }
    
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Integer id,
                      HttpServletRequest request,
                      @ModelAttribute Questionnaire questionnaire,
                      RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权编辑此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        questionnaire.setId(id);
        if (questionnaireService.update(questionnaire)) {
            redirectAttributes.addFlashAttribute("message", "问卷更新成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "问卷更新失败！");
        }
        
        return "redirect:/questionnaire/list";
    }
    
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id,
                        HttpServletRequest request,
                        RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权删除此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaireService.deleteById(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷删除成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "问卷删除失败！");
        }
        
        return "redirect:/questionnaire/list";
    }
    
    @GetMapping("/publish/{id}")
    public String publish(@PathVariable Integer id,
                         HttpServletRequest request,
                         RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权发布此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaireService.publish(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷发布成功！");
        } else {
            redirectAttributes.addFlashAttribute("error", "问卷发布失败！");
        }
        
        return "redirect:/questionnaire/list";
    }
    
    @GetMapping("/design/{id}")
    public String design(@PathVariable Integer id,
                        HttpServletRequest request,
                        Model model,
                        RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        Questionnaire questionnaire = questionnaireService.findById(id);
        
        if (questionnaire == null) {
            redirectAttributes.addFlashAttribute("error", "问卷不存在！");
            return "redirect:/questionnaire/list";
        }
        
        if (!questionnaire.getCreatedBy().equals(user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权设计此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        List<Question> questions = questionService.findByQuestionnaireId(id);
        
        model.addAttribute("questionnaire", questionnaire);
        model.addAttribute("questions", questions);
        
        return "questionnaire/design";
    }
    
    @GetMapping("/star/{id}")
    public String star(@PathVariable Integer id,
                      HttpServletRequest request,
                      RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权操作此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaireService.star(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷已添加到星标！");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作失败！");
        }
        
        return "redirect:/questionnaire/list";
    }
    
    @GetMapping("/unstar/{id}")
    public String unstar(@PathVariable Integer id,
                        HttpServletRequest request,
                        RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权操作此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaireService.unstar(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷已取消星标！");
        } else {
            redirectAttributes.addFlashAttribute("error", "操作失败！");
        }
        
        return "redirect:/questionnaire/list";
    }
    
    @GetMapping("/softdelete/{id}")
    public String softDelete(@PathVariable Integer id,
                            HttpServletRequest request,
                            RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权删除此问卷！");
            return "redirect:/questionnaire/list";
        }
        
        if (questionnaireService.softDelete(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷已移动到回收站！");
        } else {
            redirectAttributes.addFlashAttribute("error", "删除失败！");
        }
        
        return "redirect:/questionnaire/list";
    }
    
    @GetMapping("/restore/{id}")
    public String restore(@PathVariable Integer id,
                         HttpServletRequest request,
                         RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权恢复此问卷！");
            return "redirect:/questionnaire/recycle";
        }
        
        if (questionnaireService.restore(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷已恢复！");
        } else {
            redirectAttributes.addFlashAttribute("error", "恢复失败！");
        }
        
        return "redirect:/questionnaire/recycle";
    }
    
    @GetMapping("/permanentdelete/{id}")
    public String permanentDelete(@PathVariable Integer id,
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        
        if (!questionnaireService.isOwner(id, user.getId()) && 
            !user.getRole().equals("admin") && 
            !user.getRole().equals("administrator")) {
            redirectAttributes.addFlashAttribute("error", "无权永久删除此问卷！");
            return "redirect:/questionnaire/recycle";
        }
        
        if (questionnaireService.deletePermanently(id, user.getId())) {
            redirectAttributes.addFlashAttribute("message", "问卷已永久删除！");
        } else {
            redirectAttributes.addFlashAttribute("error", "永久删除失败！");
        }
        
        return "redirect:/questionnaire/recycle";
    }
    
    // 获取用户的文件夹列表（AJAX接口）
    @GetMapping("/api/folders")
    @ResponseBody
    public Map<String, Object> getUserFolders(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        User user = getCurrentUser(request);
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "未登录");
            return result;
        }
        
        try {
            List<Folder> folders = folderService.getUserFolders(user);
            result.put("success", true);
            result.put("folders", folders);
            result.put("message", "获取成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "获取失败：" + e.getMessage());
        }
        
        return result;
    }
    
    // 移动问卷到文件夹（AJAX接口）
    @PostMapping("/api/moveToFolder")
    @ResponseBody
    public Map<String, Object> moveToFolder(@RequestBody Map<String, Integer> params,
                                           HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        User user = getCurrentUser(request);
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "未登录");
            return result;
        }
        
        try {
            Integer questionnaireId = params.get("questionnaireId");
            Integer folderId = params.get("folderId");
            
            // 验证问卷所有权
            if (!questionnaireService.isOwner(questionnaireId, user.getId()) && 
                !user.getRole().equals("admin") && 
                !user.getRole().equals("administrator")) {
                result.put("success", false);
                result.put("message", "无权操作此问卷！");
                return result;
            }
            
            // 更新问卷的folder_id
            boolean success = questionnaireService.moveToFolder(questionnaireId, folderId);
            
            if (success) {
                result.put("success", true);
                result.put("message", "移动成功");
            } else {
                result.put("success", false);
                result.put("message", "移动失败");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "操作失败：" + e.getMessage());
        }
        
        return result;
    }
}