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

  public getChallenges(user: number): Promise<LeaderBoardCollection> {
    const requestOptions = {
      method: "GET",
      headers: { "Content-Type": "application/json" },
    };
    console.log(requestOptions);
    return fetch(
      "https://70c6-178-239-165-206.ngrok.io/api/v1/challenge/?user=" +
        user,
      requestOptions
    )
      .then((response) => response.json())
      .then((response) => {
        const outputArray = [];
        for (const element of response) {
          console.log(element);
          outputArray.push({
            id: element.id as number,
            created_at: element.created_at as string,
            title: element.title as string,
            description: element.description as string,
            end_date: element.end_date as string,
            deleted: element.deleted as boolean,
            private: element.private as boolean,
            password: element.password as string,
            owner: element.owner as number,
          });
        }

        return {
          challenges: outputArray,
        };
      });
  }
}
export interface LeaderBoardCollection {
  challenges: {
    id: number;
    created_at: string;
    title: string;
    description: string;
    end_date: string;
    deleted: boolean;
    private: boolean;
    password: string;
    owner: number;
  }[];
}
export interface DataCollection {
  datasets: {
    backgroundColor: string;
    data: number[];
    label: string;
  }[];
  labels: number[];
}
