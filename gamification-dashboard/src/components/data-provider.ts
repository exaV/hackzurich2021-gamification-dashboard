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

  public async getChallenges(user: number): Promise<LeaderBoardCollection> {
    const requestOptions = {
      method: "GET",
      headers: { "Content-Type": "application/json" },
    };
    const response = await fetch(
      `${window.location.origin}/api/v1/challenge/?user=${user}`,
      requestOptions
    );
    const data = await response.json();
    console.log("data", data);
    return {
      challenges: data as unknown as Challenge[],
    };
  }

  public async getChallengeEntry(challenge: number): Promise<ChallengeEntry[]> {
    const requestOptions = {
      method: "GET",
      headers: { "Content-Type": "application/json" },
    };
    const response = await fetch(
      `${window.location.origin}/api/v1/challengeentry?challenge=${challenge}`,
      requestOptions
    );
    const data = await response.json();
    console.log("data", data);
    return data as unknown as ChallengeEntry[];
  }
}

export interface LeaderBoardCollection {
  challenges: Challenge[];
}

export interface Challenge {
  id: number;
  type: string;
  created_at: string;
  title: string;
  description: string;
  end_date: string;
  deleted: boolean;
  private: boolean;
  password: string;
  owner: number;
}

export interface ChallengeEntry {
  id: number;
  value: number;
  user: User;
}

export interface User {
  id: number;
  last_login: Date | null;
  is_superuser: boolean;
  username: string;
  first_name: string;
  last_name: string;
  email: string;
  is_staff: boolean;
  is_active: boolean;
  date_joined: Date;
  groups: any[];
  user_permissions: any[];
}

export interface DataCollection {
  datasets: {
    backgroundColor: string;
    data: number[];
    label: string;
  }[];
  labels: number[];
}
