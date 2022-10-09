package kr.ac.kyonggi.cs.handler.dto.grdBack;

import java.util.Date;

public class BackContestDataDTO {
    private int perId;
    private String contestName;
    private String contestContent;
    private String organization;
    private Date awardDate;
    private Date openDate;
    private String awardFileName;
    private String addFileName;
    private String teamType;

    public int getPerId() {
        return perId;
    }

    public void setPerId(int perId) {
        this.perId = perId;
    }

    public String getContestName() {
        return contestName;
    }

    public void setContestName(String contestName) {
        this.contestName = contestName;
    }

    public String getContestContent() {
        return contestContent;
    }

    public void setContestContent(String contestContent) {
        this.contestContent = contestContent;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public Date getAwardDate() {
        return awardDate;
    }

    public void setAwardDate(Date awardDate) {
        this.awardDate = awardDate;
    }

    public Date getOpenDate() {
        return openDate;
    }

    public void setOpenDate(Date openDate) {
        this.openDate = openDate;
    }

    public String getAwardFileName() {
        return awardFileName;
    }

    public void setAwardFileName(String awardFileName) {
        this.awardFileName = awardFileName;
    }

    public String getAddFileName() {
        return addFileName;
    }

    public void setAddFileName(String addFileName) {
        this.addFileName = addFileName;
    }

    public String getTeamType() {
        return teamType;
    }

    public void setTeamType(String teamType) {
        this.teamType = teamType;
    }
}
