package cz.uhk.fim.dbs2dataflow.model;

public class HalaInfo extends Hala{
    int pocetZarizeni;

    public HalaInfo(int pocetZarizeni, Hala hala) {
        this.setHalaID(hala.getHalaID());
        this.setOznaceni(hala.getOznaceni());
        this.setTovarna(hala.getTovarna());
        this.pocetZarizeni = pocetZarizeni;
    }

    public int getPocetZarizeni() {
        return pocetZarizeni;
    }


    public void setPocetZarizeni(int pocetZarizeni) {
        this.pocetZarizeni = pocetZarizeni;
    }
}
