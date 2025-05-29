package dto;

public class LoginResult {
    private Member member;
    private boolean isFirstLogin;

    public LoginResult(Member member, boolean isFirstLogin) {
        this.member = member;
        this.isFirstLogin = isFirstLogin;
    }

    public Member getMember() {
        return member;
    }

    public boolean isFirstLogin() {
        return isFirstLogin;
    }
}
