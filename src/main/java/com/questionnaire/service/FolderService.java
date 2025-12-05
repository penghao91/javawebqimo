package com.questionnaire.service;

import com.questionnaire.dao.FolderDao;
import com.questionnaire.model.Folder;
import com.questionnaire.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FolderService {
    
    @Autowired
    private FolderDao folderDao;
    
    public List<Folder> getUserFolders(User user) {
        return folderDao.findByUserId(user.getId());
    }
    
    public Folder getFolderById(Integer id) {
        return folderDao.findById(id);
    }
    
    public boolean createFolder(Folder folder, User user) {
        folder.setUserId(user.getId());
        return folderDao.insert(folder) > 0;
    }
    
    public boolean updateFolder(Folder folder) {
        return folderDao.update(folder) > 0;
    }
    
    public boolean deleteFolder(Integer id) {
        return folderDao.delete(id) > 0;
    }
    
    public Folder findDefaultFolder(Integer userId) {
        return folderDao.findByNameAndUserId(userId, "未分类");
    }
}