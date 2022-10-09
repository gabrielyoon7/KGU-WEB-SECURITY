package kr.ac.kyonggi.cs.handler.dto.grdBack;

import java.util.Date;

public class BackConferenceDataDTO {
    private int perId;
    private String conferenceName;
    private String requirement;
    private String thesisTitle;
    private String organization;
    private Date openDate;
    private String thesisFileName;
    private String proofFileName;

    public int getPerId() {
        return perId;
    }

    public void setPerId(int perId) {
        this.perId = perId;
    }

    public String getConferenceName() {
        return conferenceName;
    }

    public void setConferenceName(String conferenceName) {
        this.conferenceName = conferenceName;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getThesisTitle() {
        return thesisTitle;
    }

    public void setThesisTitle(String thesisTitle) {
        this.thesisTitle = thesisTitle;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public Date getOpenDate() {
        return openDate;
    }

    public void setOpenDate(Date openDate) {
        System.out.println(openDate);
        this.openDate = openDate;
    }

    public String getThesisFileName() {
        return thesisFileName;
    }

    public void setThesisFileName(String thesisFileName) {
        this.thesisFileName = thesisFileName;
    }

    public String getProofFileName() {
        return proofFileName;
    }

    public void setProofFileName(String proofFileName) {
        this.proofFileName = proofFileName;
    }
}
