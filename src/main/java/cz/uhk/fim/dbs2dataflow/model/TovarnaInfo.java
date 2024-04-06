package cz.uhk.fim.dbs2dataflow.model;

public class TovarnaInfo extends Tovarna{
    private Integer pocetHal;

    public Integer getPocetHal() {
        return pocetHal;
    }

    public void setPocetHal(Integer pocetHal) {
        this.pocetHal = pocetHal;
    }
    public TovarnaInfo(Tovarna tovarna, int pocetHal){
        super();
        setAdresa(tovarna.getAdresa());
        setCenazakwh(tovarna.getCenazakwh());
        setFoto(tovarna.getFoto());
        setId(tovarna.getId());
        setNazev(tovarna.getNazev());
        this.pocetHal = pocetHal;
    }
}
