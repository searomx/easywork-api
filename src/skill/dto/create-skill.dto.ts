export interface CreateSkillDto {
  name: string;
  cnae: string;
  user: {
    connect: {
      id: number;
    };
  };
}
