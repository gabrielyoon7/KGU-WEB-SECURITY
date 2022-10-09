package kr.ac.kyonggi.cs.handler.dto.grdBack;

import java.util.Date;

public class BackCertificateDataDTO {
    private int perId;
    private String requirement;
    private String cerId;
    private String organization;
    private Date acqDate;
    private String cerFileName;

    public int getPerId() {
        return perId;
    }

    public void setPerId(int perId) {
        this.perId = perId;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getCerId() {
        return cerId;
    }

    public void setCerId(String cerId) {
        this.cerId = cerId;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public Date getAcqDate() {
        return acqDate;
    }

    public void setAcqDate(Date acqDate) {
        this.acqDate = acqDate;
    }

    public String getCerFileName() {
        return cerFileName;
    }

    public void setCerFileName(String cerFileName) {
        this.cerFileName = cerFileName;
    }
}
