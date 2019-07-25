package mybean;

public class source_bean {
    String Tea_ID,Cou_ID,Sou_ID,Sou_Name;
    int Type,Sum_Count,Share;

    public String getSou_Name() {
        return Sou_Name;
    }

    public void setSou_Name(String Sou_Name) {
        this.Sou_Name = Sou_Name;
    }

    public int getShare() {
        return Share;
    }

    public void setShare(int Share) {
        this.Share = Share;
    }

    public String getTea_ID() {
        return Tea_ID;
    }

    public void setTea_ID(String Tea_ID) {
        this.Tea_ID = Tea_ID;
    }

    public String getCou_ID() {
        return Cou_ID;
    }

    public void setCou_ID(String Cou_ID) {
        this.Cou_ID = Cou_ID;
    }

    public String getSou_ID() {
        return Sou_ID;
    }

    public void setSou_ID(String Sou_ID) {
        this.Sou_ID = Sou_ID;
    }

    public int getType() {
        return Type;
    }

    public void setType(int Type) {
        this.Type = Type;
    }

    public int getSum_Count() {
        return Sum_Count;
    }

    public void setSum_Count(int Sum_Count) {
        this.Sum_Count = Sum_Count;
    }
}
