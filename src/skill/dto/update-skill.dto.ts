import { CreateSkillDto } from './create-skill.dto';

export interface UpdateSkillDto extends Partial<CreateSkillDto> {
  id?: number;
}
