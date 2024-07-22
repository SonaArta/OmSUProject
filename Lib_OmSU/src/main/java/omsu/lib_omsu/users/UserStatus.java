package omsu.lib_omsu.users;

public class UserStatus {
    Long id = 0L;
    String status = "";

    public UserStatus() {
        id = -1L;
        status = "";
    }

    public UserStatus(Long id, String status) {
        this.id = id;
        this.status = status;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "UserStatus{" +
                "id=" + id +
                ", status='" + status + '\'' +
                '}';
    }
}
