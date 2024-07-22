package omsu.lib_omsu.users;

import java.util.Collection;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;

public class UserStatusCollection {

    public static final Long idLibrarianStatus = 1L;
    public static final Long idReaderStatus = 2L;

    Map<Long, UserStatus> userStatusMap= new LinkedHashMap<>();

    public UserStatusCollection() {}

    public UserStatus get(Long id){
        return userStatusMap.get(id);
    }

    public void add(UserStatus status) {
        userStatusMap.put(status.getId(), status);
    }

    public void remove(UserStatus status){
        userStatusMap.remove(status.getId());
    }

    @Override
    public String toString(){
        return userStatusMap.toString();
    }

    public Collection<UserStatus> findAll(){
        return userStatusMap.values();
    }

    public HashSet<UserStatus> getUserStatusValues() {
        System.out.println("userStatus="+userStatusMap.values());
        return new HashSet<UserStatus>(userStatusMap.values());
    }

    public void setUserStatusCollection(Map<Long, UserStatus> userStatusMap) {
        this.userStatusMap = userStatusMap;
    }
}
