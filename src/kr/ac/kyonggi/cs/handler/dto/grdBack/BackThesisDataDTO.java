package kr.ac.kyonggi.cs.handler.dto.grdBack;

public class BackThesisDataDTO {
    private int perId;
    private String title;
    private String classification;
    private String keyword;
    private String proposalContent;
    private String interimFileName;
    private String finalRequirement;
    private int finalPage;
    private String finalFileName;

    public int getPerId() {
        return perId;
    }

    public void setPerId(int perId) {
        this.perId = perId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getClassification() {
        return classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getProposalContent() {
        return proposalContent;
    }

    public void setProposalContent(String proposalContent) {
        this.proposalContent = proposalContent;
    }

    public String getInterimFileName() {
        return interimFileName;
    }

    public void setInterimFileName(String interimFileName) {
        this.interimFileName = interimFileName;
    }

    public String getFinalRequirement() {
        return finalRequirement;
    }

    public void setFinalRequirement(String finalRequirement) {
        this.finalRequirement = finalRequirement;
    }

    public int getFinalPage() {
        return finalPage;
    }

    public void setFinalPage(int finalPage) {
        this.finalPage = finalPage;
    }

    public String getFinalFileName() {
        return finalFileName;
    }

    public void setFinalFileName(String finalFileName) {
        this.finalFileName = finalFileName;
    }
}
