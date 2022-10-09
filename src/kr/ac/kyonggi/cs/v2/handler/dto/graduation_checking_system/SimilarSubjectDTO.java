package kr.ac.kyonggi.cs.v2.handler.dto.graduation_checking_system;
//
//public class SimilarSubjectDTO {
//    int oid;
//    String origin_lec, new_lec;
//
//    public int getOid() {
//        return oid;
//    }
//
//    public void setOid(int oid) {
//        this.oid = oid;
//    }
//
//    public String getOrigin_lec() {
//        return origin_lec;
//    }
//
//    public void setOrigin_lec(String origin_lec) {
//        this.origin_lec = origin_lec;
//    }
//
//    public String getNew_lec() {
//        return new_lec;
//    }
//
//    public void setNew_lec(String new_lec) {
//        this.new_lec = new_lec;
//    }
//}

public class SimilarSubjectDTO {
    int oid;
//    String origin_lec, new_lec;

    public int getOid() {
        return oid;
    }

    public void setOid(int oid) {
        this.oid = oid;
    }

//    public String getOrigin_lec() {
//        return origin_lec;
//    }
//
//    public void setOrigin_lec(String origin_lec) {
//        this.origin_lec = origin_lec;
//    }
//
//    public String getNew_lec() {
//        return new_lec;
//    }
//
//    public void setNew_lec(String new_lec) {
//        this.new_lec = new_lec;
//    }

    String lectures;

    public String getLectures() {
        return lectures;
    }

    public void setLectures(String lectures) {
        this.lectures = lectures;
    }
}
