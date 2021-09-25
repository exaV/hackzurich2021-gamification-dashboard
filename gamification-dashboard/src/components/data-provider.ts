export class DataProvider {
  public randomCollection(size = 2): DataCollection {
    return {
      labels: [this.getRandomInt()],
      datasets: [...Array(size).keys()].map((index) => {
        return {
          label: `Data ${index}`,
          backgroundColor: "#f87979",
          data: [this.getRandomInt()],
        };
      }),
    };
  }

  public getRandomInt(): number {
    return Math.floor(Math.random() * (50 - 5 + 1)) + 5;
  }
}

export interface DataCollection {
  datasets: {
    backgroundColor: string;
    data: number[];
    label: string;
  }[];
  labels: number[];
}
