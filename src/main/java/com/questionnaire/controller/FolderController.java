package com.questionnaire.controller;

import com.questionnaire.model.Folder;
import com.questionnaire.model.User;
import com.questionnaire.service.FolderService;
import com.questionnaire.service.QuestionnaireService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/folder")
public class FolderController {

    @Resource
    private FolderService folderService;
    
    @Resource
    private QuestionnaireService questionnaireService;

    private User getCurrentUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute("user");
    }

    @GetMapping("/list")
    public String list(HttpServletRequest request) {
        User user = getCurrentUser(request);
        if (user == null) {
            return "redirect:/user/login";
        }
        return "questionnaire/folders";
    }

    @PostMapping("/api/create")
    @ResponseBody
    public Map<String, Object> create(@RequestBody Map<String, String> params,
                                       HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        User user = getCurrentUser(request);
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "未登录");
            return result;
        }

        try {
            String folderName = params.get("name");
            if (folderName == null || folderName.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "文件夹名称不能为空");
                return result;
            }

            Folder folder = new Folder();
            folder.setName(folderName.trim());

            String parentIdStr = params.get("parentId");
            if (parentIdStr != null && !parentIdStr.trim().isEmpty()) {
                try {
                    folder.setParentId(Integer.parseInt(parentIdStr));
                } catch (NumberFormatException e) {
                    result.put("success", false);
                    result.put("message", "无效的父文件夹ID");
                    return result;
                }
            } else {
                folder.setParentId(null); // 根文件夹
            }

            boolean success = folderService.createFolder(folder, user);
            
            if (success) {
                result.put("success", true);
                result.put("message", "文件夹创建成功");
                result.put("folder", folder);
            } else {
                result.put("success", false);
                result.put("message", "文件夹创建失败");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "创建失败：" + e.getMessage());
        }

        return result;
    }

    @GetMapping("/api/list")
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
            
            // 如果没有文件夹，创建一个默认的未分类文件夹
            if (folders == null || folders.isEmpty()) {
                Folder defaultFolder = new Folder();
                defaultFolder.setName("未分类");
                defaultFolder.setParentId(null);
                folderService.createFolder(defaultFolder, user);
                folders = folderService.getUserFolders(user);
            }
            
            result.put("success", true);
            result.put("folders", folders);
            result.put("message", "获取成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "获取失败：" + e.getMessage());
        }

        return result;
    }
    
    @PutMapping("/api/update/{id}")
    @ResponseBody
    public Map<String, Object> update(@PathVariable Integer id,
                                       @RequestBody Map<String, String> params,
                                       HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        User user = getCurrentUser(request);
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "未登录");
            return result;
        }

        try {
            String folderName = params.get("name");
            if (folderName == null || folderName.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "文件夹名称不能为空");
                return result;
            }

            Folder folder = folderService.getFolderById(id);
            if (folder == null) {
                result.put("success", false);
                result.put("message", "文件夹不存在");
                return result;
            }
            
            // 验证所有权
            if (!folder.getUserId().equals(user.getId()) && 
                !user.getRole().equals("admin") && 
                !user.getRole().equals("administrator")) {
                result.put("success", false);
                result.put("message", "无权操作此文件夹");
                return result;
            }

            folder.setName(folderName.trim());
            boolean success = folderService.updateFolder(folder);
            
            if (success) {
                result.put("success", true);
                result.put("message", "文件夹重命名成功");
                result.put("folder", folder);
            } else {
                result.put("success", false);
                result.put("message", "文件夹重命名失败");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "重命名失败：" + e.getMessage());
        }

        return result;
    }
    
    @DeleteMapping("/api/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Integer id,
                                       HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        User user = getCurrentUser(request);
        
        if (user == null) {
            result.put("success", false);
            result.put("message", "未登录");
            return result;
        }

        try {
            Folder folder = folderService.getFolderById(id);
            if (folder == null) {
                result.put("success", false);
                result.put("message", "文件夹不存在");
                return result;
            }
            
            // 验证所有权
            if (!folder.getUserId().equals(user.getId()) && 
                !user.getRole().equals("admin") && 
                !user.getRole().equals("administrator")) {
                result.put("success", false);
                result.put("message", "无权操作此文件夹");
                return result;
            }
            
            // 检查是否是默认文件夹（ID为0或1的通常作为默认）
            if (id == 0 || id == 1) {
                result.put("success", false);
                result.put("message", "默认文件夹不能删除");
                return result;
            }

            // 删除文件夹前，将文件夹内的问卷移动到默认文件夹（ID为0）
            questionnaireService.moveQuestionnairesToFolder(id, 0);
            
            boolean success = folderService.deleteFolder(id);
            
            if (success) {
                result.put("success", true);
                result.put("message", "文件夹删除成功");
            } else {
                result.put("success", false);
                result.put("message", "文件夹删除失败");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "删除失败：" + e.getMessage());
        }

        return result;
    }
}