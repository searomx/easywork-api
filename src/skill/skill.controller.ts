import {
  Controller,
  Get,
  Post,
  Body,
  Put,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { SkillService } from './skill.service';
import { CreateSkillDto } from './dto/create-skill.dto';
import { UpdateSkillDto } from './dto/update-skill.dto';

@Controller('skills')
export class SkillController {
  constructor(private readonly skillService: SkillService) {}

  @Post()
  criarSkill(@Body() createSkillDto: CreateSkillDto) {
    return this.skillService.criarSkill(createSkillDto);
  }

  @Get()
  buscarTodosSkills() {
    return this.skillService.buscarTodosSkills();
  }

  @Get(':id')
  buscarUmSkill(@Param('id') id: string) {
    return this.skillService.buscarUmSkill(+id);
  }

  @Put()
  alterarTodosSkills() {
    return this.skillService.alterarTodosSkills();
  }

  @Patch(':id')
  alterarUmSkill(
    @Param('id') id: string,
    @Body() updateSkillDto: UpdateSkillDto,
  ) {
    return this.skillService.alterarUmSkill(+id, updateSkillDto);
  }

  @Delete(':id')
  excluirUmSkill(@Param('id') id: string) {
    return this.skillService.excluirUmSkill(+id);
  }
}
